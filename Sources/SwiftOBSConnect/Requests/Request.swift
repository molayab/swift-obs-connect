//
//  File.swift
//  
//
//  Created by Mateo Olaya on 19/01/23.
//

import Foundation

public struct GetVersionResponse: Codable {
    public var obsVersion: String
    public var obsWebSocketVersion: String
    public var rpcVersion: Int
    public var availableRequests: [String]
    public var supportedImageFormats: [String]
    public var platform: String
    public var platformDescription: String
}

public struct GetStatsResponse: Codable {
    public var cpuUsage: Double // in %
    public var memoryUsage: Double // in MB
    public var availableDiskSpace: Double
    public var activeFps: Double
    public var averageFrameRenderTime: Double
    public var renderSkippedFrames: Int
    public var renderTotalFrames: Double
    public var outputSkippedFrames: Int
    public var outputTotalFrames: Int
    public var webSocketSessionIncomingMessages: Int
    public var webSocketSessionOutgoingMessages: Int
}


public struct BroadcastCustomEventResponse: Codable {
    public var eventData: [String: Any]
    
    enum CodingKeys: String, CodingKey {
        case eventData
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        eventData = try values.decode([String: Any].self, forKey: .eventData)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(eventData, forKey: .eventData)
    }
}

public enum Response {
    case GetVersion(GetVersionResponse)
    case GetStats(GetStatsResponse)
    case BroadcastCustomEvent(BroadcastCustomEventResponse)
    
    enum type: String, Codable {
        case GetVersion
        case GetStats
        case BroadcastCustomEvent
    }
}

extension Response: Codable {
    private enum CodingKeys: String, CodingKey {
        case requestType, requestId, requestData, responseData
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(Response.type.self, forKey: .requestType)
        
        switch type {
        case .GetVersion:
            let model = try container.decode(GetVersionResponse.self, forKey: .responseData)
            self = .GetVersion(model)
        case .GetStats:
            let model = try container.decode(GetStatsResponse.self, forKey: .responseData)
            self = .GetStats(model)
        case .BroadcastCustomEvent:
            let model = try container.decode(
                BroadcastCustomEventResponse.self,
                forKey: .responseData)
            self = .BroadcastCustomEvent(model)
        default:
            fatalError("Not implemented!! TODO")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(UUID().uuidString, forKey: .requestId)
        
        switch self {
        case .GetVersion:
            try container.encode(Request.type.GetVersion.rawValue, forKey: .requestType)
        case .GetStats:
            try container.encode(Request.type.GetStats.rawValue, forKey: .requestType)
        case .BroadcastCustomEvent:
            try container.encode(Request.type.BroadcastCustomEvent.rawValue, forKey: .requestType)
        default:
            fatalError("Not implemented!! TODO")
        }
    }
}

public enum Request {
    case invalidRequest
    case SetCurrentProgramScene
    case GetVersion
    case GetStats
    case BroadcastCustomEvent(any Codable)
    
    enum type: String, Codable {
        case SetCurrentProgramScene
        case GetVersion
        case GetStats
        case BroadcastCustomEvent
        case CallVendorRequest
        case GetHotkeyList
        case TriggerHotkeyByName
        case TriggerHotkeyByKeySequence
        case Sleep
    }
}

extension Request: Codable {
    private enum CodingKeys: String, CodingKey {
        case requestType, requestId, requestData, eventData
    }
    
    public init(from decoder: Decoder) throws {
        self = .invalidRequest
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(UUID().uuidString, forKey: .requestId)
        
        switch self {
        case .GetVersion:
            try container.encode(Request.type.GetVersion.rawValue, forKey: .requestType)
        case .GetStats:
            try container.encode(Request.type.GetStats.rawValue, forKey: .requestType)
        case .BroadcastCustomEvent(let model):
            var requestContainer = container
                .nestedContainer(keyedBy: CodingKeys.self, forKey: .requestData)
            try container.encode(Request.type.BroadcastCustomEvent.rawValue, forKey: .requestType)
            try requestContainer.encode(model, forKey: .eventData)
        default:
            fatalError("Not implemented!! TODO")
        }
    }
}
