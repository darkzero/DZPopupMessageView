# DZPopupMessageView

[![CI Status](http://img.shields.io/travis/darkzero/DZPopupMessageView.svg?style=flat)](https://travis-ci.org/darkzero/DZPopupMessageView)
[![Version](https://img.shields.io/cocoapods/v/DZPopupMessageView.svg?style=flat)](http://cocoapods.org/pods/DZPopupMessageView)
[![License](https://img.shields.io/cocoapods/l/DZPopupMessageView.svg?style=flat)](http://cocoapods.org/pods/DZPopupMessageView)
[![Platform](https://img.shields.io/cocoapods/p/DZPopupMessageView.svg?style=flat)](http://cocoapods.org/pods/DZPopupMessageView)

## simple message display queue

- How to use

```Swift
DZPopupMessageView.showPopupMessage(<Message String>, 
                                    inView: <In View> _nullable, default is UIApplocation.shared.keywindow,
                                    disappearAfter: <Disappear After x.x seconds> _nullable, default is 1.5,
                                    callback: <Callback Function> _nu_nullable);
```

Can be used like these

```Swift
DZPopupMessageView.showPopupMessage("Message body");
DZPopupMessageView.showPopupMessage("Message body", inView: <Target View>);
DZPopupMessageView.showPopupMessage("Message body", inView: <Target View>, disappearAfter: 1.0);
DZPopupMessageView.showPopupMessage("Message body", inView: <Target View>, disappearAfter: 1.0) {
    // Do something
};
...
```


## Requirements
Xcode

## Installation

DZPopupMessageView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DZPopupMessageView"
```

## Author

darkzero, darkzero_mk2@hotmail.com

## License

DZPopupMessageView is available under the MIT license. See the LICENSE file for more info.
