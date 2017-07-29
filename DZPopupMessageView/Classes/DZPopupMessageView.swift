//
//  DZPopupMessageView.swift
//  Pods
//
//  Created by darkzero on 16/5/15.
//
//

import UIKit

open class DZPopupMessageView: UIView {
    
    var parentView: UIView?;
    var messageLabel: UILabel = UILabel(frame: CGRect(x: 10, y: 5, width: 220, height: 22));
    var callback:()->Void = {() -> Void in};
    var disappearDelay: TimeInterval = 1.0;
    
    fileprivate var _message = "";
    var message:String {
        get {
            return _message;
        }
        set(value) {
            _message = value;
            self.messageLabel.text = value;
        }
    };
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(message: String) {
        let rect = (message as NSString).boundingRect(with: CGSize(width: 220, height: 0),
                                                              options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                              attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 12.0)],
                                                              context: nil);
        let labelRect   = CGRect(x: 10, y: 5, width: 220, height: rect.height);
        let viewRect    = CGRect(x: 0, y: 0, width: 240, height: rect.height+10);
        self.messageLabel.frame = labelRect;
        self.messageLabel.textAlignment = NSTextAlignment.center;
        self.messageLabel.font = UIFont.systemFont(ofSize: 12.0);
        self.messageLabel.textColor = UIColor.white;
        self.messageLabel.numberOfLines = 0;
        self.messageLabel.lineBreakMode = NSLineBreakMode.byWordWrapping;
        super.init(frame: viewRect);
        self.message = message;
        self.backgroundColor = UIColor(white: 0.2, alpha: 0.7);
        self.layer.cornerRadius = 8.0;
        self.addSubview(self.messageLabel);
    }
    
    open class func showPopupMessage(_ message: String, inView view: UIView, DisappearAfter disappearDelay:TimeInterval, Callback callback:@escaping ()->Void) {
        let msgView = DZPopupMessageView(message: message);
        msgView.parentView = view;
        msgView.callback = callback;
        msgView.disappearDelay = disappearDelay;
        
        DZPopupMessageQueueManager.shared.addPopupMessage(msgView);
    }
    
    open class func clearMessageQueue() {
        DZPopupMessageQueueManager.shared.clearAllQueue();
    }
    
    func showWithAnimation(_ animation: Bool) {
        //
        self.parentView?.addSubview(self);
        
        self.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height);
        self.alpha = 0.0;
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: { 
            self.alpha = 1.0;
            self.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2);
        }) { (finished) in
            self.hideWithAnimation(animation);
        }
    }
    
    func hideWithAnimation(_ animation: Bool) {
        //
        UIView.animate(withDuration: 0.5, delay: self.disappearDelay, options: UIViewAnimationOptions.curveLinear, animations: {
            self.alpha = 0.5;
            self.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/4);
        }) { (finished) in
            DZPopupMessageQueue.shared.messageList.removeLast();
            DZPopupMessageQueueManager.shared.next();
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: { 
                self.alpha = 0.0;
                self.center = CGPoint(x: UIScreen.main.bounds.width/2, y: 0);
            }, completion: { (finished) in
                self.removeFromSuperview();
                self.callback();
            })
        }
    }
}
