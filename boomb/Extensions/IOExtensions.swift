//
//  IOExtensions.swift
//  boomb
//
//  Created by Felipe Passos on 20/10/25.
//

import SwiftUI

class IO {
    public static func handleSocketDecoding<T: Decodable>(
        event: String,
        data: [Any],
        type: T.Type,
        handle: (T) -> Void
    ) {
        guard data.count > 0, JSONSerialization.isValidJSONObject(data[0]) else {
            print("Received invalid JSON object in \(event):", data)
            return
        }
        
        do {
            let dat = try JSONSerialization.data(withJSONObject: data[0])
            let res = try JSONDecoder().decode(T.self, from: dat)
            handle(res)
        } catch {
            print("Decoding error in \(event):", error)
        }
    }
}
