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

  s.description      = <<-DESC
Popup Message View with queue
* How to use
```
DZPopupMessageView.showPopupMessage(<Message String>, inView: <In View>, DisappearAfter: <Disappear After x.x seconds>, Callback: <Callback Function>)
```
                       DESC

  s.homepage         = "https://github.com/darkzero/DZPopupMessageView"
  s.license          = 'MIT'
  s.author           = { "darkzero" => "darkzero_mk2@hotmail.com" }
  s.source           = { :git => "https://github.com/darkzero/DZPopupMessageView.git", :tag => s.version.to_s }

  s.ios.deployment_target = '9.3'

  s.source_files = 'DZPopupMessageView/Classes/**/*'
  s.resources = ['DZPopupMessageView/Assets/*.png', 'DZPopupMessageView/Assets/*.xcassets']
end
