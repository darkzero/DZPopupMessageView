//
//  DZPopupMessageQueueManager.swift
//  Pods
//
//  Created by darkzero on 16/5/15.
//
//

import UIKit

public class DZPopupMessageQueueManager: NSObject {
    
    lazy var messageQueuse: DZPopupMessageQueue = {
        let queue = DZPopupMessageQueue.sharedInstance;
        return queue;
    }();
    var isRunning = false;
    
    //MARK: - class functions
    /// Singleton
    class var sharedInstance : DZPopupMessageQueueManager {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : DZPopupMessageQueueManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = DZPopupMessageQueueManager();
        }
        return Static.instance!
    }
    
    override init() {
        super.init();
        self.messageQueuse.addObserver(self, forKeyPath: "messageList", options: NSKeyValueObservingOptions([.Old,.New]), context: nil);
    }
    
    public func addPopupMessage(message: DZPopupMessageView) {
        dispatch_sync(dispatch_queue_create("add_popup_message", nil)) {
            self.messageQueuse.addMessage(message);
        }
    }
    
    public func clearAllQueue() {
        if ( isRunning ) {
            isRunning = false;
            self.messageQueuse.messageList.removeAll();
        }
    }
    
    public func next() {
        if ( self.messageQueuse.count() > 0  ) {
            self.isRunning = true;
            let msgPopup = (self.messageQueuse.messageList.last)! as DZPopupMessageView;
            msgPopup.showWithAnimation(true);
        }
        else {
            self.isRunning = false;
        }
    }
    
    public override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
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
