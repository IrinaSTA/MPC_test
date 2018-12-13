//
//  Device.swift
//  MPCTest
//
//  Created by Irina Baldwin on 13/12/2018.
//  Copyright © 2018 Irina Baldwin. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class Device: NSObject {
    let peerID: MCPeerID
    var session: MCSession?
    var name: String
    var state = MCSessionState.notConnected
    
    init(peerID: MCPeerID) {
        self.name = peerID.displayName
        self.peerID = peerID
        super.init()
    }
    
    func invite(with browser: MCNearbyServiceBrowser) {
        browser.invitePeer(self.peerID, to: self.session!, withContext: nil, timeout: 10)
    }
    
    func connect() {
        if self.session != nil { return }
        self.session = MCSession(peer: MPCManager.instance.localPeerID, securityIdentity: nil, encryptionPreference: .required)
        self.session?.delegate = self
    }
}
