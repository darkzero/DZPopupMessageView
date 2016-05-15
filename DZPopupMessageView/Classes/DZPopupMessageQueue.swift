//
//  DZPopupMessageQueue.swift
//  Pods
//
//  Created by darkzero on 16/5/15.
//
//

import UIKit

public class DZPopupMessageQueue: NSObject {
    
    //MARK: - properties
    public dynamic var messageList: Array<DZPopupMessageView> = Array<DZPopupMessageView>();
    var messageCount: Int = 0;
    
    //MARK: - class functions
    /// Singleton
    public class var sharedInstance : DZPopupMessageQueue {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : DZPopupMessageQueue? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = DZPopupMessageQueue()
        }
        return Static.instance!
    }
    
    func insertObject(object: DZPopupMessageView, inMessageListAtIndex index: Int) {
        self.messageList.insert(object, atIndex: index);
    }
    
    func removeObjectFromMessageListAtIndex(index: Int) {
        self.messageList.removeAtIndex(index);
    }
    
    func addMessage(message: DZPopupMessageView) {
        self.insertObject(message, inMessageListAtIndex: 0);
    }
    
    func count() -> Int {
        let c = DZPopupMessageQueue.sharedInstance.messageList.count;
        return c;
    }
}
