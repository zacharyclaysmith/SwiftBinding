Pod::Spec.new do |s|

s.name         = "SwiftBinding"
s.version      = "1.1.0"
s.summary      = "A Binding Library for the Swift language."

s.description  = <<-DESC
This is a terribly simplistic "binding framework" written in Swift. There's nothing super special about it...it's just glorified object wrappers that call listener functions when the values change.

This is meant to be a stand-alone library, but to see the companion UI stuff I built on top, check out https://github.com/zacharyclaysmith/SwiftBindingUI.

If you want something with way more stars and more code, please check out https://github.com/SwiftBond/Bond. It's scarily similar to this project (unintentional), but it looks to have a number of neat additions and more robust documentation. I don't like the coupling of the View and Binding code in a single project, but whatevs.
DESC

s.homepage     = "https://github.com/zacharyclaysmith/SwiftBinding"
s.license      = { :type => "MIT", :file => "LICENSE.md" }
s.author             = { "Zachary Clay Smith" => "Zachary.Clay.Smith@gmail.com" }
s.ios.deployment_target = "8.0"
s.osx.deployment_target = "10.10"
s.source       = { :git => "https://github.com/zacharyclaysmith/SwiftBinding.git", :tag => s.version }
s.source_files  = "SwiftBinding/**/*.swift"
s.requires_arc = true

end