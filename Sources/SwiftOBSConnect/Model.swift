//
//  File.swift
//  
//
//  Created by Mateo Olaya on 18/01/23.
//

import Foundation

public struct HelloModel: Codable {
    public var obsWebSocketVersion: String
    public var rpcVersion: Int
    public var authentication: AuthenticationModel?
}

public struct AuthenticationModel: Codable {
    public var challenge: String
    public var salt: String
}

public struct IdentifyModel: Codable {
    public init(rpcVersion: Int,
                authentication: String? = nil,
                eventSubscriptions: EventSubscription) {
        self.rpcVersion = rpcVersion
        self.authentication = authentication
        self.eventSubscriptions = eventSubscriptions.rawValue
    }
    
    public var rpcVersion: Int
    public var authentication: String?
    public var eventSubscriptions: UInt
}

public struct ReplayBufferStateChanged: Codable {
    public var outputActive: Bool
    public var outputState: String
}

public struct VirtualcamStateChanged: Codable {
    public var outputActive: Bool
    public var outputState: String
}

public struct ReplayBufferSaved: Codable {
    public var savedReplayPath: String
}

public struct IdentifiedModel: Codable {
    public var negotiatedRpcVersion: Int
}

public struct RequestStatusModel: Codable {
    public var result: Bool
    public var code: Int
    public var comment: String?
}

public struct SceneRemoved: Codable {
    public var sceneName: String
    public var isGroup: Bool
}

public struct SceneNameChanged: Codable {
    public var oldSceneName: String
    public var sceneName: String
}

public struct CurrentProgramSceneChanged: Codable {
    public var sceneName: String
}

public struct CurrentPreviewSceneChanged: Codable {
    public var sceneName: String
}

public struct SceneListChanged: Codable {
    // var scenes: [Scene]
}

public struct StreamStateChanged: Codable {
    public var outputActive: Bool
    public var outputState: String
}

public struct RecordStateChanged: Codable {
    public var outputActive: Bool
    public var outputState: String
    public var outputPath: String
}

/// CONFIG EVENTS

public struct CurrentSceneCollectionChanging: Codable {
    public var sceneCollectionName: String
}

public struct CurrentSceneCollectionChanged: Codable {
    public var sceneCollectionName: String
}

public struct SceneCollectionListChanged: Codable {
    public var sceneCollections: [String]
}

public struct CurrentProfileChanging: Codable {
    public var profileName: String
}

public struct CurrentProfileChanged: Codable {
    public var profileName: String
}

public struct ProfileListChanged: Codable {
    public var profiles: [String]
}

/// SCENE EVENTS

public struct SceneCreated: Codable {
    public var sceneName: String
    public var isGroup: Bool
}





public struct InputVolumeMeters: Codable {
    public var inputs: [Any]
    
    enum CodingKeys: String, CodingKey {
        case inputs
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        inputs = try values.decode([Any].self, forKey: .inputs)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(inputs, forKey: .inputs)
    }
}

public struct InputAudioMonitorTypeChanged: Codable {
    public enum MonitorType: String, Codable {
        case none = "OBS_MONITORING_TYPE_NONE"
        case monitorOnly = "OBS_MONITORING_TYPE_MONITOR_ONLY"
        case monitorAndOutput = "OBS_MONITORING_TYPE_MONITOR_AND_OUTPUT"
    }
    
    public var inputName: String
    public var monitorType: MonitorType
}

public struct InputAudioTracksChanged: Codable {
    public var inputName: String
    // public var inputAudioTracks: String
}

public struct InputAudioSyncOffsetChanged: Codable {
    public var inputName: String
    public var inputAudioSyncOffset: Double
}

public struct InputAudioBalanceChanged: Codable {
    public var inputName: String
    public var inputAudioBalance: Double // New audio balance value of the input
}

public struct InputVolumeChanged: Codable {
    public var inputName: String
    public var inputVolumeMul: Double // New volume level multiplier
    public var inputVolumeDb: Double // New volume level in dB
}

public struct InputMuteStateChanged: Codable {
    public var inputName: String
    public var inputMuted: Bool
}

public struct InputActiveStateChanged: Codable {
    public var inputName: String
    public var videoActive: Bool
}

public struct InputNameChanged: Codable {
    public var oldInputName: String
    public var inputName: String
}

public struct InputRemoved: Codable {
    public var inputName: String
}

public struct InputShowStateChanged: Codable {
    public var inputName: String
    public var videoShowing: Bool
}

public struct InputCreated: Codable {
    public var inputName: String
    public var inputKind: String
    public var unversionedInputKind: String
    public var inputSettings: [String: Any]
    public var defaultInputSettings: [String: Any]
    
    enum CodingKeys: String, CodingKey {
        case inputName, inputKind, unversionedInputKind, inputSettings, defaultInputSettings
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        inputName = try values.decode(String.self, forKey: .inputName)
        inputKind = try values.decode(String.self, forKey: .inputKind)
        unversionedInputKind = try values.decode(String.self, forKey: .unversionedInputKind)
        inputSettings = try values.decode([String: Any].self, forKey: .inputSettings)
        defaultInputSettings = try values.decode([String: Any].self, forKey: .defaultInputSettings)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(inputName, forKey: .inputName)
        try container.encode(inputKind, forKey: .inputKind)
        try container.encode(unversionedInputKind, forKey: .unversionedInputKind)
        try container.encode(inputSettings, forKey: .inputSettings)
        try container.encode(defaultInputSettings, forKey: .defaultInputSettings)
    }
}
