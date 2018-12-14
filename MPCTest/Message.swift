//
//  Message.swift
//  MPCTest
//
//  Created by Chris Cooksley on 13/12/2018.
//  Copyright © 2018 Irina Baldwin. All rights reserved.
//

import Foundation

struct Message: Codable {
    let body: String
}

extension Device {
    func send(text: String) throws {
        let message = Message(body: text)
        let payload = try JSONEncoder().encode(message)
        try self.session?.send(payload, toPeers: [self.PeerID], with: .reliable)
    }
}
