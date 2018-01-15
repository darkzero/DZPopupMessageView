//
//  DZPopupMessageQueue.swift
//  Pods
//
//  Created by darkzero on 16/5/15.
//
//

import UIKit

open class DZPopupMessageQueue: NSObject {
    
    //MARK: - properties
    @objc open dynamic var messageList: Array<DZPopupMessageView> = Array<DZPopupMessageView>();
    var messageCount: Int = 0;
    
    // MARK: - Singleton
    static var shared : DZPopupMessageQueue = {DZPopupMessageQueue()}();
    
    // MARK: - Insert & Remove Objects
    
    /// insert a message object into queue array
    func insertObject(_ object: DZPopupMessageView, inMessageListAtIndex index: Int) {
        self.messageList.insert(object, at: index);
    }
    
    func removeObjectFromMessageListAtIndex(_ index: Int) {
        self.messageList.remove(at: index);
    }
    
    func addMessage(_ message: DZPopupMessageView) {
        self.insertObject(message, inMessageListAtIndex: 0);
    }
    
    func count() -> Int {
        let c = DZPopupMessageQueue.shared.messageList.count;
        return c;
    }
}
