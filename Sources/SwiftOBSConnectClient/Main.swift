//
//  File.swift
//  
//
//  Created by Mateo Olaya on 19/01/23.
//

import Foundation
import SwiftOBSConnect
import Combine

@main
struct SwiftOBSClient {
    static var cancellables: [AnyCancellable] = []
    
    static func main() async throws {
        let a = SwiftOBSConnect()
        await a.statePublisher().sink { state in
            print(" --> STATE: \(state)")
        }.store(in: &cancellables)
        
        if let url = URL(string: "ws://192.168.10.112:4455") {
            try? await a.connect(url: url, password: "supersecretpassword")
            print("Connected successfully")

            await a.eventPublisher().sink { completion in
                print(completion)
            } receiveValue: { event in
                print(event)
            }.store(in: &cancellables)
            
            // Request something is easy:
            /*if case let .GetVersion(model) = await a.send(request: .GetVersion) {
                print(" YAY - \(model.obsVersion)")
            }*/
            
            let result: GetVersionResponse = try await a.send(request: .GetVersion)
            print(result.platform)
        }
        
        
        
        while(true) { }
    }
}
