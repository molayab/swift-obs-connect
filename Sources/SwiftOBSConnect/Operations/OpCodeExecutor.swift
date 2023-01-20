import Foundation
import Combine

protocol OpCode {
    init(_ config: OpCodeExecutor.Configuration)
    func exec(payload: Data?) async throws -> OpCodeExecutor.NextAction
}

actor OpCodeExecutor {
    enum NextAction {
        case none
        case send(any OpMessage)
    }
    
    struct Configuration {
        var password: String
        var eventSubscriptions: EventSubscription
        var statePublisher: CurrentValueSubject<SwiftOBSConnect.State, Never>
        var eventPublisher: PassthroughSubject<Event, Error>
        var responsePublisher: PassthroughSubject<Response, Error>
    }

    private weak var sender: Sender!
    init(sender: Sender!) {
        self.sender = sender
    }
    
    func exec(opCode: OpCode, payload: Data?) async throws {
        switch try await opCode.exec(payload: payload) {
        case .send(let message):
            try await sender.send(message: message)
        case .none:
            break
        }
    }
}

protocol Sender: AnyObject {
    func send(message: some OpMessage) async throws
}
