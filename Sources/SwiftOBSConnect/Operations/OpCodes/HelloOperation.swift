import Foundation
import Crypto

struct HelloOperation: OpCode {
    let config: OpCodeExecutor.Configuration
    
    init(_ config: OpCodeExecutor.Configuration) {
        self.config = config
    }
    
    func exec(payload: Data?) throws -> OpCodeExecutor.NextAction {
        guard let payload = payload else { return .none }
        let params = try JSONDecoder().decode(HelloOpMessage.self, from: payload)
        var message: IdentifyOpMessage
        
        config.statePublisher.send(.connecting)
        if let auth = params.d.authentication {
            let x = SHA256.hash(data: (config.password + auth.salt).data(using: .utf8)!)
            let y = Data(x).base64EncodedString() + auth.challenge
            let z = SHA256.hash(data: y.data(using: .utf8)!)
            let authStr = Data(z).base64EncodedString()
            
            message = IdentifyOpMessage(
                d: .init(
                    rpcVersion: 1,
                    authentication: authStr,
                    eventSubscriptions: config.eventSubscriptions))
        } else {
            // There is not an auth token
            message = IdentifyOpMessage(
                d: .init(
                    rpcVersion: 1,
                    eventSubscriptions: config.eventSubscriptions))
        }
        
        return .send(message)
    }
}
