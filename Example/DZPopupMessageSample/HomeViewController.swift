//
//  ViewController.swift
//  DZPopupMessageSample
//
//  Created by Yuhua Hu on 2019/01/23.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import DZPopupMessageView

class HomeViewController: UIViewController {
    @IBOutlet var messageField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension HomeViewController {
    @IBAction func onButtonClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        var msg = self.messageField.text ?? ""
        if msg.count <= 0 {
            msg = "Test Message"
        }
        switch sender.tag {
        case 1: // rise
            DZPopupMessageView.showPopupMessage(msg)
            break
        case 2: // TODO: drop
            DZPopupMessageView.showPopupMessage(msg, displayType: .drop)
            break
        case 3: // TODO: bubble top
            DZPopupMessageView.showPopupMessage(msg, displayType: .bubbleTop)
            break
        case 4: // TODO: bubble bottom
            DZPopupMessageView.showPopupMessage(msg, theme: .dark, displayType: .bubbleBottom)
            break
        default:
            DZPopupMessageView.showPopupMessage(msg)
            break
        }
    }
}

