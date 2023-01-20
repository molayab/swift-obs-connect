import Foundation

struct IdentifiedOperation: OpCode {
    let config: OpCodeExecutor.Configuration
    
    init(_ config: OpCodeExecutor.Configuration) {
        self.config = config
    }
    
    func exec(payload: Data?) async throws -> OpCodeExecutor.NextAction {
        guard let payload = payload else { return .none }
        let params = try JSONDecoder().decode(IndentifiedOpMessage.self, from: payload)
        guard params.d.negotiatedRpcVersion == 1 else {
            throw NSError()
        }
        
        config.statePublisher.send(.connected)
        return .none
    }
}
