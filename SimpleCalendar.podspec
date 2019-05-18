Pod::Spec.new do |spec|
  spec.name         = "SimpleCalendar"
  spec.version      = "1.0.0"
  spec.summary      = "A simple calendar for iOS devices (iphone)."
  spec.description  = <<-DESC
                Display calendar easy with SimpleCalendar controller.
                   DESC
  spec.homepage     = "https://github.com/bilalBakhrom/SimpleCalendar"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Bilal Bakhrom" => "bilalbakhrom@gmail.com" }
  spec.platform     = :ios, "10.0"
  spec.source       = { :git => "https://github.com/bilalBakhrom/SimpleCalendar.git", :tag => "1.0.0" }
  spec.source_files  = "Classes", "SimpleCalendar/Classes/**/*"
  spec.resources = "Resources/*.png"
end
