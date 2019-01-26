#
# Be sure to run `pod lib lint DZPopupMessageView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "DZPopupMessageView"
  s.version          = "0.3.0"
  s.summary          = "DZPopupMessageView."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description = <<-DESC
## Popup Message View with queue
### How to use
  
* **Import**
  
```Swift
import DZPopupMessageView
```
  
* **Show message**
  
```Swift
/// paramters
/// - message text: String
/// - theme: DZPopupMessage.Theme(enum)
///     can be nil, default is .light
/// - type: DZPopupMessage.MessageType(enum)
///     can be nil, default is .info
/// - display: DZPopupMessage.DisplayType(enum)
///     can be nil, default is .bubbleTop
DZPopupMessage.show({msg text}, theme: {theme}, type: {type}, display: {display}, callback: {
    // do some thing
    })
```
                      
* **Paramaters**
    * theme
        - DZPopupMessage.Theme.light
        - DZPopupMessage.Theme.dark
                      
    * type
        - DZPopupMessage.MessageType.info
        - DZPopupMessage.MessageType.warning
        - DZPopupMessage.MessageType.error
                      
    * display
        - DZPopupMessage.DisplayType.rise
        - DZPopupMessage.DisplayType.drop
        - DZPopupMessage.DisplayType.bubbleTop
        - DZPopupMessage.DisplayType.bubbleBottom
                      
#### Can be used like these
                      
```Swift
DZPopupMessage.show("Message body");
DZPopupMessage.show({msg text}, theme: {theme}, type: {type}, display: {display});
DZPopupMessage.show({msg text}, theme: {theme}, type: {type});
...
```

DESC

  s.homepage         = "https://github.com/darkzero/DZPopupMessageView"
  s.license          = 'MIT'
  s.author           = { "darkzero" => "darkzero_mk2@hotmail.com" }
  s.source           = { :git => "https://github.com/darkzero/DZPopupMessageView.git", :tag => s.version.to_s }

  s.ios.deployment_target = '9.3'

  s.source_files = 'DZPopupMessageView/Classes/**/*'
  s.resources = ['DZPopupMessageView/Assets/*.xcassets']
  #s.resource_bundles = {
  #  "DZPopupMessageView" => ['DZPopupMessageView/Assets/*.xcassets']
  #}
end
