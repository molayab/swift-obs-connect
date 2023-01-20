import Foundation

struct ResponseOperation: OpCode {
    let config: OpCodeExecutor.Configuration
    
    init(_ config: OpCodeExecutor.Configuration) {
        self.config = config
    }
    
    func exec(payload: Data?) throws -> OpCodeExecutor.NextAction {
        guard let payload = payload else { return .none }
        let params = try JSONDecoder().decode(RequestResponseOpMessage.self, from: payload)
        
        config.responsePublisher.send(params.d)
        return .none
    }
}

