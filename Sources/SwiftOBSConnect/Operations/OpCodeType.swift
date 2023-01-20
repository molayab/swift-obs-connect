import Foundation

enum OpCodeType: Int, Codable {
    case hello = 0
    case identify = 1
    case identified = 2
    case reidentify = 3
    case event = 5
    case request = 6
    case requestResponse = 7
    case requestBatch = 8
    case requestBatchResponse = 9
    
    func getState(usingConfig config: OpCodeExecutor.Configuration) -> OpCode {
        switch self {
        case .hello:
            return HelloOperation(config)
        case .identify:
            fatalError("This is a server responsability")
        case .identified:
            return IdentifiedOperation(config)
        case .reidentify:
            return HelloOperation(config)
        case .event:
            return EventOperation(config)
        case .request:
            return RequestOperation(config)
        case .requestResponse:
            return ResponseOperation(config)
        case .requestBatch:
            return HelloOperation(config) // TOOD
        case .requestBatchResponse:
            return HelloOperation(config) // TODO
        }
    }
}

// Mark: - Supported Messages

public struct OpRootMessage: Codable {
    public var op: Int
}

public struct HelloOpMessage: OpMessage {
    var op: OpCodeType = .hello
    public let d: HelloModel
}

public struct IdentifyOpMessage: OpMessage {
    var op: OpCodeType = .identify
    public let d: IdentifyModel
}

public struct IndentifiedOpMessage: OpMessage {
    var op: OpCodeType = .identified
    public let d: IdentifiedModel
}

/*public struct ReidentifyOpMessage: OpMessage {
    var op: OpCodeType = .reidentify
    public let d: ReidentifyModel
}*/

public struct EventOpMessage: OpMessage {
    var op: OpCodeType = .event
    public let d: Event
}

public struct RequestOpMessage: OpMessage {
    var op: OpCodeType = .request
    public let d: Request
}

public struct RequestResponseOpMessage: OpMessage {
    var op: OpCodeType = .requestResponse
    public let d: Response
}

// Mark: - Protocol

protocol OpMessage: Codable {
    associatedtype D: Codable
    var op: OpCodeType { get }
    var d: D { get }
}
