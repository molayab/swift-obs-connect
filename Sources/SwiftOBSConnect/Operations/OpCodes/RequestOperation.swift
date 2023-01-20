import Foundation
import Crypto

struct RequestOperation: OpCode {
    let config: OpCodeExecutor.Configuration
    
    init(_ config: OpCodeExecutor.Configuration) {
        self.config = config
    }
    
    func exec(payload: Data?) throws -> OpCodeExecutor.NextAction {
        return .none
    }
}
