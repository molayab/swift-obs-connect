# SwiftOBSConnect

This package is an unofficial implementation of [OBS WebSocket Protocol](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md). This framework abstracts all the protocol implementation and provides a reactive way to interact with OBS programmatically using Swift.


#### Quick use 

```swift
let client = SwiftOBSConnect()
await client.statePublisher().sink { state in
    // Arrived some state change...
}.store(in: &cancellables)

await a.eventPublisher().sink { _ in } receiveValue: { event in
    // Received an new Event, do something with it...
}.store(in: &cancellables)

try? await client.connect(
    url: URL(string: "ws://192.168.10.112:4455")!,
    password: "supersecretpassword")

// At this point, you are connected to the OBS, try sending some
// commands or keep listening for changes and events.

let result: GetVersionResponse = try await client.send(request: .getVersion)
print(result.platform)
// Sends a GetVersion request and awaits for its response.
```

## Introduction
### OBS' native web socket introduction 

OBS offers a way to control and listen to events via networking using a web socket. With this socket, you can interact with the OBS application remotely. OBS has defined a protocol (API) for controlling and listening to events using 9 basic operand codes (OpCodes). There is a 3rd-party (obs-websocket) plugin used for some old instances. Now, obs-websocket is included by default with OBS Studio 28.0.0 and above. As such, there should be no need to download obs-websocket if you have OBS Studio > 28.0.0.

#### Activate it...

If you are running OBS Studio > 28.0.0, then you can enable in the menu option (Tools -> WebSocket Server Settings). Otherwise, you will need first to install the obs-websocket plugin.

![WebSocket Setting in Menu](/Documentation/Resources/webserver-settings-menu.png)

### Requirements

 - Swift 5.7 or above
 - macOS 13.0 or above
 - iOS 16.0 or above 
 - iPadOS 16.0 or above
 
*__Note:__ This package has not been tested nor adapted to support the Linux environment. It should be compatible with some minor changes due the project is made based on Swift's foundation.*

## How to install

It uses SwiftPackageManager as dependency manager.

## How to use 

### Interface

## Architecture

## Colaborate

## Credits

