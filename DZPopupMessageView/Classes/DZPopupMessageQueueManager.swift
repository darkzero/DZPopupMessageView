//
//  DZPopupMessageQueueManager.swift
//  Pods
//
//  Created by darkzero on 16/5/15.
//
//

import UIKit

open class DZPopupMessageQueueManager: NSObject {
    
    lazy var messageQueuse: DZPopupMessageQueue = {
        let queue = DZPopupMessageQueue.shared;
        return queue;
    }();
    
    var isRunning = false;
    
    //MARK: - class functions
    /// Singleton
    static let shared : DZPopupMessageQueueManager = {DZPopupMessageQueueManager()}();
    
    override init() {
        super.init();
        self.messageQueuse.addObserver(self, forKeyPath: "messageList", options: NSKeyValueObservingOptions([.old,.new]), context: nil);
    }
    
    open func addPopupMessage(_ message: DZPopupMessageView) {
        DispatchQueue(label: "add_popup_message", attributes: []).sync {
            self.messageQueuse.addMessage(message);
        }
    }
    
    open func clearAllQueue() {
        if ( isRunning ) {
            isRunning = false;
            self.messageQueuse.messageList.removeAll();
        }
    }
    
    open func next() {
        if ( self.messageQueuse.count() > 0  ) {
            self.isRunning = true;
            let msgPopup = (self.messageQueuse.messageList.last)! as DZPopupMessageView;
            msgPopup.showWithAnimation(true);
        }
        else {
            self.isRunning = false;
        }
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if ( keyPath == "messageList" ) {
            if ( !self.isRunning ) {
                self.next();
            }
        }
    }
    
//    - (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
//    if ( [keyPath isEqualToString:@"messageList"] ) {
//    if ( !self.isRunning ) {
//    [self next];
//    }
//    }
//    }

}
