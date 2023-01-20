import Foundation

public struct EventSubscription: OptionSet, Codable {
    public let rawValue: UInt
    
    public static let none = EventSubscription([])
    public static let general = EventSubscription(rawValue: 1 << 0)
    public static let config = EventSubscription(rawValue: 1 << 1)
    public static let scenes = EventSubscription(rawValue: 1 << 2)
    public static let inputs = EventSubscription(rawValue: 1 << 3)
    public static let transitions = EventSubscription(rawValue: 1 << 4)
    public static let filters = EventSubscription(rawValue: 1 << 5)
    public static let outputs = EventSubscription(rawValue: 1 << 6)
    public static let sceneItems = EventSubscription(rawValue: 1 << 7)
    public static let mediaInputs = EventSubscription(rawValue: 1 << 8)
    public static let vendors = EventSubscription(rawValue: 1 << 9)
    public static let ui = EventSubscription(rawValue: 1 << 10)
    public static let all = EventSubscription.general
        .union(.config)
        .union(.scenes)
        .union(.inputs)
        .union(.transitions)
        .union(.filters)
        .union(.outputs)
        .union(.sceneItems)
        .union(.mediaInputs)
        .union(.vendors)
        .union(.ui)
    public static let inputVolumeMeters = EventSubscription(rawValue: 1 << 16)
    public static let inputActiveStateChanged = EventSubscription(rawValue: 1 << 17)
    public static let inputShowStateChanged = EventSubscription(rawValue: 1 << 18)
    public static let sceneItemTransformChanged = EventSubscription(rawValue: 1 << 19)
    
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
}
