import Foundation

public enum Event {
    case exitStarted(Int)
    case customEvent([String: Any], Int)
    case currentSceneCollectionChanging(CurrentSceneCollectionChanging, Int)
    case currentSceneCollectionChanged(CurrentSceneCollectionChanged, Int)
    case sceneCollectionListChanged(SceneCollectionListChanged, Int)
    case currentProfileChanging(CurrentProfileChanging, Int)
    case currentProfileChanged(CurrentProfileChanged, Int)
    case profileListChanged(ProfileListChanged, Int)
    case sceneCreated(SceneCreated, Int)
    case sceneRemoved(SceneRemoved, Int)
    case sceneNameChanged(SceneNameChanged, Int)
    case currentProgramSceneChanged(CurrentProgramSceneChanged, Int)
    case currentPreviewSceneChanged(CurrentPreviewSceneChanged, Int)
    case sceneListChanged(SceneListChanged, Int)
    case inputCreated(InputCreated, Int)
    case inputRemoved(InputRemoved, Int)
    case inputNameChanged(InputNameChanged, Int)
    case inputActiveStateChanged(InputActiveStateChanged, Int)
    case inputShowStateChanged(InputShowStateChanged, Int)
    case inputMuteStateChanged(InputMuteStateChanged, Int)
    case inputVolumeChanged(InputVolumeChanged, Int)
    case inputAudioBalanceChanged(InputAudioBalanceChanged, Int)
    case inputAudioSyncOffsetChanged(InputAudioSyncOffsetChanged, Int)
    case inputAudioTracksChanged(InputAudioTracksChanged, Int)
    case inputAudioMonitorTypeChanged(InputAudioMonitorTypeChanged, Int)
    case inputVolumeMeters(InputVolumeMeters, Int)
    case currentSceneTransitionChanged(Int)
    case currentSceneTransitionDurationChanged(Int)
    case sceneTransitionStarted(Int)
    case sceneTransitionEnded(Int)
    case sceneTransitionVideoEnded(Int)
    case sourceFilterListReindexed(Int)
    case sourceFilterCreated(Int)
    case sourceFilterRemoved(Int)
    case sourceFilterNameChanged(Int)
    case sourceFilterEnableStateChanged(Int)
    case sceneItemCreated(Int)
    case sceneItemRemoved(Int)
    case sceneItemListReindexed(Int)
    case sceneItemEnableStateChanged(Int)
    case sceneItemLockStateChanged(Int)
    case sceneItemSelected(Int)
    case sceneItemTransformChanged(Int)
    case streamStateChanged(StreamStateChanged, Int)
    case recordStateChanged(RecordStateChanged, Int)
    case replayBufferStateChanged(ReplayBufferStateChanged, Int)
    case virtualcamStateChanged(VirtualcamStateChanged, Int)
    case replayBufferSaved(ReplayBufferSaved, Int)
    case mediaInputPlaybackStarted(Int)
    case mediaInputPlaybackEnded(Int)
    case mediaInputActionTriggered(Int)
    case studioModeStateChanged(Int)
    case screenshotSaved(Int)
    
    enum type: String, Codable {
        case exitStarted = "ExitStarted"
        case customEvent = "CustomEvent"
        case currentSceneCollectionChanging = "CurrentSceneCollectionChanging"
        case currentSceneCollectionChanged = "CurrentSceneCollectionChanged"
        case sceneCollectionListChanged = "SceneCollectionListChanged"
        case currentProfileChanging = "CurrentProfileChanging"
        case currentProfileChanged = "CurrentProfileChanged"
        case profileListChanged = "ProfileListChanged"
        case sceneCreated = "SceneCreated"
        case sceneRemoved = "SceneRemoved"
        case sceneNameChanged = "SceneNameChanged"
        case currentProgramSceneChanged = "CurrentProgramSceneChanged"
        case currentPreviewSceneChanged = "CurrentPreviewSceneChanged"
        case sceneListChanged = "SceneListChanged"
        case inputCreated = "InputCreated"
        case inputRemoved = "InputRemoved"
        case inputNameChanged = "InputNameChanged"
        case inputActiveStateChanged = "InputActiveStateChanged"
        case inputShowStateChanged = "InputShowStateChanged"
        case inputMuteStateChanged = "InputMuteStateChanged"
        case inputVolumeChanged = "InputVolumeChanged"
        case inputAudioBalanceChanged = "InputAudioBalanceChanged"
        case inputAudioSyncOffsetChanged = "InputAudioSyncOffsetChanged"
        case inputAudioTracksChanged = "InputAudioTracksChanged"
        case inputAudioMonitorTypeChanged = "InputAudioMonitorTypeChanged"
        case inputVolumeMeters = "InputVolumeMeters"
        case currentSceneTransitionChanged = "CurrentSceneTransitionChanged"
        case currentSceneTransitionDurationChanged = "CurrentSceneTransitionDurationChanged"
        case sceneTransitionStarted = "SceneTransitionStarted"
        case sceneTransitionEnded = "SceneTransitionEnded"
        case sceneTransitionVideoEnded = "SceneTransitionVideoEnded"
        case sourceFilterListReindexed = "SourceFilterListReindexed"
        case sourceFilterCreated = "SourceFilterCreated"
        case sourceFilterRemoved = "SourceFilterRemoved"
        case sourceFilterNameChanged = "SourceFilterNameChanged"
        case sourceFilterEnableStateChanged = "SourceFilterEnableStateChanged"
        case sceneItemCreated = "SceneItemCreated"
        case sceneItemRemoved = "SceneItemRemoved"
        case sceneItemListReindexed = "SceneItemListReindexed"
        case sceneItemEnableStateChanged = "SceneItemEnableStateChanged"
        case sceneItemLockStateChanged = "SceneItemLockStateChanged"
        case sceneItemSelected = "SceneItemSelected"
        case sceneItemTransformChanged = "SceneItemTransformChanged"
        case streamStateChanged = "StreamStateChanged"
        case recordStateChanged = "RecordStateChanged"
        case replayBufferStateChanged = "ReplayBufferStateChanged"
        case virtualcamStateChanged = "VirtualcamStateChanged"
        case replayBufferSaved = "ReplayBufferSaved"
        case mediaInputPlaybackStarted = "MediaInputPlaybackStarted"
        case mediaInputPlaybackEnded = "MediaInputPlaybackEnded"
        case mediaInputActionTriggered = "MediaInputActionTriggered"
        case studioModeStateChanged = "StudioModeStateChanged"
        case screenshotSaved = "ScreenshotSaved"
    }
}

extension Event: Codable {
    private enum CodingKeys: String, CodingKey {
        case eventType, eventIntent, eventData
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(Event.type.self, forKey: .eventType)
        
        switch type {
        case .exitStarted:
            let intent = try container.decode(Int.self, forKey: .eventIntent)
            self = .exitStarted(intent)
        case .replayBufferSaved:
            let item = try container.decode(ReplayBufferSaved.self, forKey: .eventData)
            let intent = try container.decode(Int.self, forKey: .eventIntent)
            self = .replayBufferSaved(item, intent)
        case .virtualcamStateChanged:
            let item = try container.decode(VirtualcamStateChanged.self, forKey: .eventData)
            let intent = try container.decode(Int.self, forKey: .eventIntent)
            self = .virtualcamStateChanged(item, intent)
        case .currentProfileChanged:
            let item = try container.decode(CurrentProfileChanged.self, forKey: .eventData)
            let intent = try container.decode(Int.self, forKey: .eventIntent)
            self = .currentProfileChanged(item, intent)
        case .streamStateChanged:
            let item = try container.decode(StreamStateChanged.self, forKey: .eventData)
            let intent = try container.decode(Int.self, forKey: .eventIntent)
            self = .streamStateChanged(item, intent)
        case .recordStateChanged:
            let item = try container.decode(RecordStateChanged.self, forKey: .eventData)
            let intent = try container.decode(Int.self, forKey: .eventIntent)
            self = .recordStateChanged(item, intent)
        case .replayBufferStateChanged:
            let item = try container.decode(ReplayBufferStateChanged.self, forKey: .eventData)
            let intent = try container.decode(Int.self, forKey: .eventIntent)
            self = .replayBufferStateChanged(item, intent)
        case .customEvent:
            let item = try container.decode([String: Any].self, forKey: .eventData)
            let intent = try container.decode(Int.self, forKey: .eventIntent)
            self = .customEvent(item, intent)
        case .inputCreated:
            let item = try container.decode(InputCreated.self, forKey: .eventData)
            let intent = try container.decode(Int.self, forKey: .eventIntent)
            self = .inputCreated(item, intent)
        case .inputRemoved:
            let item = try container.decode(InputRemoved.self, forKey: .eventData)
            let intent = try container.decode(Int.self, forKey: .eventIntent)
            self = .inputRemoved(item, intent)
        case .inputNameChanged:
            let item = try container.decode(InputNameChanged.self, forKey: .eventData)
            let intent = try container.decode(Int.self, forKey: .eventIntent)
            self = .inputNameChanged(item, intent)
        case .inputActiveStateChanged:
            let item = try container.decode(InputActiveStateChanged.self, forKey: .eventData)
            let intent = try container.decode(Int.self, forKey: .eventIntent)
            self = .inputActiveStateChanged(item, intent)
        case .inputShowStateChanged:
            let item = try container.decode(InputShowStateChanged.self, forKey: .eventData)
            let intent = try container.decode(Int.self, forKey: .eventIntent)
            self = .inputShowStateChanged(item, intent)
        case .inputMuteStateChanged:
            let item = try container.decode(InputMuteStateChanged.self, forKey: .eventData)
            let intent = try container.decode(Int.self, forKey: .eventIntent)
            self = .inputMuteStateChanged(item, intent)
        case .inputVolumeChanged:
            let item = try container.decode(InputVolumeChanged.self, forKey: .eventData)
            let intent = try container.decode(Int.self, forKey: .eventIntent)
            self = .inputVolumeChanged(item, intent)
        case .inputAudioBalanceChanged:
            let item = try container.decode(InputAudioBalanceChanged.self, forKey: .eventData)
            let intent = try container.decode(Int.self, forKey: .eventIntent)
            self = .inputAudioBalanceChanged(item, intent)
        case .inputAudioSyncOffsetChanged:
            let item = try container.decode(InputAudioSyncOffsetChanged.self, forKey: .eventData)
            let intent = try container.decode(Int.self, forKey: .eventIntent)
            self = .inputAudioSyncOffsetChanged(item, intent)
        case .inputAudioTracksChanged:
            let item = try container.decode(InputAudioTracksChanged.self, forKey: .eventData)
            let intent = try container.decode(Int.self, forKey: .eventIntent)
            self = .inputAudioTracksChanged(item, intent)
        case .inputAudioMonitorTypeChanged:
            let item = try container.decode(InputAudioMonitorTypeChanged.self, forKey: .eventData)
            let intent = try container.decode(Int.self, forKey: .eventIntent)
            self = .inputAudioMonitorTypeChanged(item, intent)
        case .inputVolumeMeters:
            let item = try container.decode(InputVolumeMeters.self, forKey: .eventData)
            let intent = try container.decode(Int.self, forKey: .eventIntent)
            self = .inputVolumeMeters(item, intent)
        default:
            self = .exitStarted(0)
            // fatalError("TODO: Unimplemented")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        // Events are not required to be encoded.
    }
}
