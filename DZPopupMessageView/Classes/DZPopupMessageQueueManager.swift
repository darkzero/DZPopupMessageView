//
//  DZPopupMessageQueueManager.swift
//  Pods
//
//  Created by darkzero on 16/5/15.
//
//

import UIKit

public class DZPopupMessageQueueManager: NSObject {
    
    var messageQueuse: DZPopupMessageQueue?;
    var isRunning = false;
    
    //MARK: - class functions
    /// Singleton
    class var sharedInstance : DZPopupMessageQueueManager {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : DZPopupMessageQueueManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = DZPopupMessageQueueManager()
        }
        return Static.instance!
    }
    
    public func addPopupMessage(message: DZPopupMessageView) {
        dispatch_sync(dispatch_queue_create("add_popup_message", nil)) {
            self.messageQueuse!.addMessage(message);
        }
    }
    
    public func clearAllQueue() {
        if ( isRunning ) {
            isRunning = false;
            self.messageQueuse?.messageList.removeAll();
        }
    }
    
    public func next() {
        if ( self.messageQueuse!.count > 0  ) {
            self.isRunning = true;
            let msgPopup = (self.messageQueuse?.messageList.last)! as DZPopupMessageView;
            msgPopup.showWithAnimation(true);
        }
        else {
            self.isRunning = false;
        }
    }

}
