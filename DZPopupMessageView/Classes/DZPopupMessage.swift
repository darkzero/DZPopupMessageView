//
//  DZPopupMessage.swift
//  DZPopupMessageView
//
//  Created by Yuhua Hu on 2019/01/24.
//
public enum DisplayType: String {
    case rise
    case drop
    case bubbleTop
    case bubbleBottom
}

public enum Theme: String {
    case dark
    case light
    case warning
    case error
}

public struct DZPopupMessage {
    var message: String = ""
    //var icon: UIImage? = nil
    var theme: Theme = .light
    var displayType: DisplayType = .rise
    var isappearDelay: TimeInterval = 1.5
}
