#
#  Be sure to run `pod spec lint BDMessagesKeyboardController.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html

Pod::Spec.new do |s|
  s.name         = "BDMessagesKeyboardController"
  s.version      = "0.0.3"

  s.summary      = "TextEditor inspired by the iOS Messages app's chat input."

  s.description  = <<-DESC
  Inspired by how Messages and the native Facebook apps allows user to input short text, this class is a stand-alone one that allows your app to display such text input over any desired view. As more lines typed in, the control resizes accordingly. There's also an option to add an accessory view above the text input that will also auto-resize.
  DESC

  s.homepage     = "https://github.com/norsez/BDMessagesKeyboardController"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = "Norsez Orankijanan"
  s.platform     = :ios, '7.0'
  s.source       = { :git => "https://github.com/robertibiris/BDMessagesKeyboardController.git", :tag => s.version.to_s }
  s.source_files  = "classes/**/*.{h,m}"

  s.frameworks = "QuartzCore"
  s.requires_arc = true

end
