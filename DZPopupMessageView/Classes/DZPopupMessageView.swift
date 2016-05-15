//
//  DZPopupMessageView.swift
//  Pods
//
//  Created by darkzero on 16/5/15.
//
//

import UIKit

public class DZPopupMessageView: UIView {
    
    var parentView: UIView?;
    var messageLabel: UILabel = UILabel(frame: CGRectMake(10, 5, 220, 22));
    var callback:()->Void = {() -> Void in};
    var disappearDelay: NSTimeInterval = 1.0;
    
    private var _message = "";
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
        let rect = (message as NSString).boundingRectWithSize(CGSizeMake(220, 0),
                                                              options: NSStringDrawingOptions.UsesLineFragmentOrigin,
                                                              attributes: [NSFontAttributeName : UIFont.systemFontOfSize(12.0)],
                                                              context: nil);
        let labelRect   = CGRectMake(10, 5, 220, rect.height);
        let viewRect    = CGRectMake(0, 0, 240, rect.height+10);
        self.messageLabel.frame = labelRect;
        self.messageLabel.textAlignment = NSTextAlignment.Center;
        self.messageLabel.font = UIFont.systemFontOfSize(12.0);
        self.messageLabel.textColor = UIColor.whiteColor();
        self.messageLabel.numberOfLines = 0;
        self.messageLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping;
        super.init(frame: viewRect);
        self.message = message;
        self.backgroundColor = UIColor(white: 0.2, alpha: 0.7);
        self.layer.cornerRadius = 8.0;
        self.addSubview(self.messageLabel);
    }
    
    public class func showPopupMessage(message: String, inView view: UIView, DisappearAfter disappearDelay:NSTimeInterval, Callback callback:()->Void) {
        let msgView = DZPopupMessageView(message: message);
        msgView.parentView = view;
        msgView.callback = callback;
        msgView.disappearDelay = disappearDelay;
        
        DZPopupMessageQueueManager.sharedInstance.addPopupMessage(msgView);
    }
    
    public class func clearMessageQueue() {
        DZPopupMessageQueueManager.sharedInstance.clearAllQueue();
    }
    
    func showWithAnimation(animation: Bool) {
        //
        self.parentView?.addSubview(self);
        
        self.center = CGPointMake(UIScreen.mainScreen().bounds.width/2, UIScreen.mainScreen().bounds.height);
        self.alpha = 0.0;
        
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { 
            self.alpha = 1.0;
            self.center = CGPointMake(UIScreen.mainScreen().bounds.width/2, UIScreen.mainScreen().bounds.height/2);
        }) { (finished) in
            self.hideWithAnimation(animation);
        }
    }
    
    func hideWithAnimation(animation: Bool) {
        //
        UIView.animateWithDuration(0.5, delay: self.disappearDelay, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.alpha = 0.5;
            self.center = CGPointMake(UIScreen.mainScreen().bounds.width/2, UIScreen.mainScreen().bounds.height/4);
        }) { (finished) in
            DZPopupMessageQueue.sharedInstance.messageList.removeLast();
            DZPopupMessageQueueManager.sharedInstance.next();
            UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { 
                self.alpha = 0.0;
                self.center = CGPointMake(UIScreen.mainScreen().bounds.width/2, 0);
            }, completion: { (finished) in
                self.removeFromSuperview();
                self.callback();
            })
        }
    }
}
