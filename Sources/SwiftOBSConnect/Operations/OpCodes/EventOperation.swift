import Foundation

struct EventOperation: OpCode {
    let config: OpCodeExecutor.Configuration
    
    init(_ config: OpCodeExecutor.Configuration) {
        self.config = config
    }
    
    func exec(payload: Data?) async throws -> OpCodeExecutor.NextAction {
        guard let payload = payload else { return .none }
        let params = try JSONDecoder().decode(EventOpMessage.self, from: payload)
        
        config.eventPublisher.send(params.d)
        return .none
    }
}
