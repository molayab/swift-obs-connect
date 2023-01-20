import SwiftWebConnect
import Foundation
import Combine

public actor SwiftOBSConnect {
    private let socket = SwiftWebConnect.shared
    
    private var cancellables: [AnyCancellable] = []
    private var eventSubject = PassthroughSubject<Event, Error>()
    private var responseSubject = PassthroughSubject<Response, Error>()
    private var stateSubject = CurrentValueSubject<State, Never>(.disconnected)
    
    private lazy var machine = {
        return OpCodeExecutor(sender: self)
    }()
    
    public enum State {
        case connected
        case disconnected
        case connecting
    }

    public init() {
    }
    
    public func connect(url: URL, password: String? = nil) async throws {
        let eventSubject = self.eventSubject
        let responseSubject = self.responseSubject
        let stateSubject = self.stateSubject
        
        socket.configure()
        socket.connect(url: url)
        
        try await withCheckedThrowingContinuation { (inCont: CheckedContinuation<Void, Error>) in
            do {
                try socket.subscribe().sink { _ in } receiveValue: { data in
                    guard let base = try? JSONDecoder().decode(OpRootMessage.self, from: data),
                          let type = OpCodeType(rawValue: base.op) else {
                        return
                    }
                    
                    Task {
                        try await self.machine.exec(
                            opCode: type.getState(
                                usingConfig: .init(
                                    password: password ?? String(),
                                    eventSubscriptions: .all,
                                    statePublisher: stateSubject,
                                    eventPublisher: eventSubject,
                                    responsePublisher: responseSubject)),
                            payload: data)
                    }
                }.store(in: &cancellables)
                
                stateSubject.sink { state in
                    guard case .connected = state else { return }
                    inCont.resume(returning: Void())
                }.store(in: &cancellables)
            } catch {
                inCont.resume(throwing: error)
            }
        }
    }
    
    public func disconnect() {
        guard socket.isConnected else { return }
        stateSubject.send(.disconnected)
        cancellables.forEach { $0.cancel() }
        socket.disconnect()
    }
    
    public func eventPublisher() -> AnyPublisher<Event, Error> {
        return eventSubject
            .eraseToAnyPublisher()
    }
    
    public func responsePublisher() -> AnyPublisher<Response, Error> {
        return responseSubject
            .eraseToAnyPublisher()
    }
    
    public func statePublisher() -> AnyPublisher<State, Never> {
        return stateSubject
            .eraseToAnyPublisher()
    }
    
    public func send(request: Request) async {
        try? await send(message: RequestOpMessage(d: request))
    }
}

extension SwiftOBSConnect: Sender {
    func send(message: some OpMessage) async throws {
        guard let data = String(data: try JSONEncoder().encode(message), encoding: .utf8) else {
            throw NSError()
        }
        
        switch await socket.send(string: data) {
        case .success:
            print(" ---> SENT: \(data)")
        case.failure(let e):
            throw e
        }
    }
}





