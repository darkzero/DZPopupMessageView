//
//  DZPopupMessageView.swift
//  Pods
//
//  Created by darkzero on 16/5/15.
//
//

import UIKit

public class DZPopupMessageView: UIView {
    var parentView: UIView?
    var messageLabel: UILabel = UILabel(frame: CGRect(x: 10, y: 5, width: 220, height: 22))
    var callback:(()->Void)?
    var disappearDelay: TimeInterval = 1.0
    var displayType: DisplayType = .rise
    var iconImage: UIImage?
    
    fileprivate var _message = ""
    var message:String {
        get {
            return _message
        }
        set(value) {
            _message = value
            self.messageLabel.text = value
        }
    }
    
    // MARK: - init
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(message: String, theme: Theme) {
        let rect = (message as NSString).boundingRect(with: CGSize(width: 220, height: 0),
                                                      options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                      attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14.0)],
                                                      context: nil)
        let labelRect   = CGRect(x: 10, y: 5, width: 220, height: rect.height)
        let viewRect    = CGRect(x: 0, y: 0, width: 240, height: rect.height+10)
        let radius      = viewRect.height/2
        self.messageLabel.frame = labelRect
        self.messageLabel.textAlignment = NSTextAlignment.center
        self.messageLabel.font = UIFont.systemFont(ofSize: 14.0)
        self.messageLabel.numberOfLines = 0
        self.messageLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        super.init(frame: viewRect)
        self.message = message
        switch theme {
        case .dark:
            self.messageLabel.textColor = .white
            self.backgroundColor = UIColor(white: 0.2, alpha: 0.7)
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = 0.5
        case .light:
            self.messageLabel.textColor = .darkGray
            self.backgroundColor = UIColor(white: 1.0, alpha: 0.9)
            self.layer.shadowColor = UIColor.gray.cgColor
            self.layer.shadowOpacity = 0.3
            //self.layer.borderWidth = 1
            //self.layer.borderColor = UIColor.lightGray.cgColor
        case .warning:
            self.messageLabel.textColor = .white
            self.backgroundColor = UIColor.orange
        case .error:
            self.messageLabel.textColor = .white
            self.backgroundColor = UIColor.red
        }
        
        self.layer.masksToBounds = false
        
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 1
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: radius).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
        self.layer.cornerRadius = radius
        self.addSubview(self.messageLabel)
    }
    
    // MARK: - Animations
    internal func showWithAnimation(_ animation: Bool) {
        //
        self.parentView?.addSubview(self)
        let inset = DZPopupMessageView.safeAreaInsetsOf(self.parentView!)
        print(inset)
        switch self.displayType {
        case .rise, .bubbleBottom:
            self.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height)
        case .drop, .bubbleTop:
            self.center = CGPoint(x: UIScreen.main.bounds.width/2, y: -self.bounds.height)
        }
        self.alpha = 0.0
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            self.alpha = 1.0
            switch self.displayType {
            case .rise:
                self.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
                break
            case .drop:
                self.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
                break
            case .bubbleTop:
                self.center = CGPoint(x: UIScreen.main.bounds.width/2, y: 20+inset.top)
                break
            case .bubbleBottom:
                self.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height-inset.bottom-self.bounds.height)
                break
            }
        }) { (finished) in
            self.hideWithAnimation(animation)
        }
    }
    
    internal func hideWithAnimation(_ animation: Bool) {
        UIView.animate(withDuration: 0.5, delay: self.disappearDelay, options: .curveLinear, animations: {
            self.alpha = 0.5
            //self.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/4)
        }) { (finished) in
            DZPopupMessageQueue.shared.messageList.removeLast()
            DZPopupMessageQueueManager.shared.next()
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveLinear, animations: {
                self.alpha = 0.0
                switch self.displayType {
                case .rise:
                    self.center = CGPoint(x: UIScreen.main.bounds.width/2, y: 0)
                    break
                case .drop:
                    self.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height)
                    break
                case .bubbleTop:
                    self.center = CGPoint(x: UIScreen.main.bounds.width/2, y: -self.bounds.height)
                    break
                case .bubbleBottom:
                    self.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height)
                    break
                }
            }, completion: { (finished) in
                self.removeFromSuperview()
                self.callback?()
            })
        }
    }
}

extension DZPopupMessageView {
    // MARK: -
    public class func show(_ msg: DZPopupMessage) {
        self.showPopupMessage(msg.message, theme: msg.theme, displayType: msg.displayType, inView: nil, DisappearAfter: msg.isappearDelay) {
            //
        }
    }
    
    // MARK: - Public Function
    public class func showPopupMessage(_ message: String,
                                       //icon: UIImage? = nil,
                                       theme: Theme = .light,
                                       displayType: DisplayType = .rise,
                                       inView view: UIView? = nil,
                                       DisappearAfter disappearDelay:TimeInterval = 1.5,
                                       Callback callback:(()->Void)? = nil) {
        let msgView = DZPopupMessageView(message: message, theme: theme)
        if ( view != nil ) {
            msgView.parentView = view
        }
        else {
            msgView.parentView = UIApplication.shared.keyWindow
        }
//        if let _icon = icon {
//            let iconView = UIImageView(image: _icon)
//            iconView.layer.cornerRadius = (msgView.bounds.height-4)/2
//            iconView.contentMode = .scaleAspectFill
//            iconView.clipsToBounds = true
//            iconView.frame = CGRect(origin: CGPoint(x: 4, y: 4), size: CGSize(width: msgView.bounds.height-8, height: msgView.bounds.height-8))
//            iconView.backgroundColor = .lightGray
//            msgView.addSubview(iconView)
//        }
        msgView.displayType     = displayType
        msgView.callback        = callback
        msgView.disappearDelay  = disappearDelay
        DZPopupMessageQueueManager.shared.addPopupMessage(msgView)
    }
    
    public class func clearMessageQueue() {
        DZPopupMessageQueueManager.shared.clearAllQueue()
    }
}

extension DZPopupMessageView {
    class func safeAreaInsetsOf(_ view: UIView) -> UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return view.safeAreaInsets
        } else {
            // Fallback on earlier versions
            return UIEdgeInsets.zero;
        }
    }
}
