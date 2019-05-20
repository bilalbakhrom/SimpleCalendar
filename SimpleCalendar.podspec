Pod::Spec.new do |spec|
  spec.name         = "SimpleCalendar"
  spec.version      = "1.0.10"
  spec.summary      = "A simple calendar for iOS devices (iphone)."
  spec.description  = <<-DESC
                Display calendar with SimpleCalendar controller.
                   DESC
  spec.homepage     = "https://github.com/bilalBakhrom/SimpleCalendar"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Bilal Bakhrom" => "bilalbakhrom@gmail.com" }
  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/bilalBakhrom/SimpleCalendar.git", :tag => "1.0.10" }
  spec.source_files  = "SimpleCalendar/**/*.{h,m,swift,xcdatamodeld, xcassets}"
  spec.resource_bundles = {
	'SimpleCalendar' => ['SimpleCalendar/Resource/SimpleCalendar.bundle']
	}
  spec.swift_version = "5.0"
end
