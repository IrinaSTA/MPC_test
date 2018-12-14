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
    
    func disconnect() {
        self.session?.disconnect()
        self.session = nil
    }
}

extension Device: MCSessionDelegate {
    public func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        self.state = state
        NotificationCenter.default.post(name: MPCManager.Notifications.deviceDidChangeState, object: self)
    }
    
    static let messageReceivedNotification = Notification.Name("DeviceDidReceiveMessage")
    public func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let message = try? JSONDecoder().decode(Message.self, from: data) {
            NotificationCenter.default.post(name: Device.messageReceivedNotification, object: message, userInfo: ["from": self])
        }
    }
    
    public func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    public func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    public func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
}
