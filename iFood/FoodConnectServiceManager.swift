//
//  FoodConnectServiceManager.swift
//  iFood
//
//  Created by iosdev on 01/05/17.
//  Copyright © 2017 namanh. All rights reserved.
//

import Foundation
import MultipeerConnectivity

protocol FoodConnectServiceManagerDelegate {
    
    func foundPeer()
    
    func lostPeer()
    func invitationWasReceived(fromPeer: String)
    
    func connectedWithPeer(peerID: MCPeerID)

    
    
}


class FoodConnectServiceManager: NSObject  {
    private let iFoodServiceType = "iFood-service"
    var advertiser : MCNearbyServiceAdvertiser!
    var myPeerId: MCPeerID!

    var browser: MCNearbyServiceBrowser!
    var mcAdvertiserAssistant: MCAdvertiserAssistant!
    var foundPeers = [MCPeerID]()
    
    var invitationHandler: ((Bool, MCSession?)->Void)!
    
    var delegate : FoodConnectServiceManagerDelegate?

    lazy var session : MCSession = {
        let session = MCSession(peer: self.myPeerId, securityIdentity: nil, encryptionPreference: .required)
        session.delegate = self
        return session
    }()
    
    
    override init() {
        super.init()
        
        myPeerId = MCPeerID(displayName: UIDevice.current.name)
        
        session = MCSession(peer: myPeerId)
        session.delegate = self
        
        browser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: "iFood-service")
        browser.delegate = self
        
        advertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: "iFood-service")
        advertiser.delegate = self

        
    }
    
    
    
}

extension FoodConnectServiceManager : MCBrowserViewControllerDelegate {
    
    func browserViewController(_: MCBrowserViewController, shouldPresentNearbyPeer: MCPeerID, withDiscoveryInfo: [String : String]?) -> Bool{
        return true
    }
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController){
    }
    func browserViewControllerWasCancelled(_: MCBrowserViewController) {
    }
}

extension FoodConnectServiceManager : MCSessionDelegate {
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        NSLog("%@", "peer \(peerID) didChangeState: \(state)")
        switch state{
        case MCSessionState.connected:
            print("Connected to session: \(session)")
            delegate?.connectedWithPeer(peerID: peerID)
            
        case MCSessionState.connecting:
            print("Connecting to session: \(session)")
            
        default:
            print("Did not connect to session: \(session)")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        let dictionary: [String: AnyObject] = ["data": data as AnyObject, "fromPeer": peerID]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "receivedMPCDataNotification"), object: dictionary)

    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        NSLog("%@", "didReceiveStream")
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        NSLog("%@", "didStartReceivingResourceWithName")
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL, withError error: Error?) {
        NSLog("%@", "didFinishReceivingResourceWithName")
    }
    
    
    
    func sendData(dictionaryWithData dictionary: Dictionary<String, String>, toPeer targetPeer: MCPeerID) -> Bool {
        let dataToSend = NSKeyedArchiver.archivedData(withRootObject: dictionary)
        let peersArray = NSArray(object: targetPeer)
        
        
        do {
            try
             session.send(dataToSend, toPeers: peersArray as! [MCPeerID], with: MCSessionSendDataMode.reliable)
                
                return true
            
            

            } catch let error as NSError {
            return false
            }
        }
}

extension FoodConnectServiceManager: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        print(error.localizedDescription)
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping ((Bool, MCSession?) -> Void)) {
        self.invitationHandler = invitationHandler         
        delegate?.invitationWasReceived(fromPeer: peerID.displayName)
    }
}

extension FoodConnectServiceManager : MCNearbyServiceBrowserDelegate {
    
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        print("%@", "didNotStartBrowsingForPeers: \(error)")
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        print("%@", "foundPeer: \(peerID)")
        NSLog("%@", "invitePeer: \(peerID)")
        foundPeers.append(peerID)
        delegate?.foundPeer()

    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        print("%@", "lostPeer: \(peerID)")
        for (index, aPeer) in foundPeers.enumerated() {
            if aPeer == peerID {
                foundPeers.remove(at: index)
                break
            }
        }
        
        delegate?.lostPeer()
    }
    
}
