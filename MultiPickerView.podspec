
Pod::Spec.new do |s|

  s.name                 = "MultiPickerView"
  s.version              = "0.0.7"
  s.summary              = "Picker View with multi row selection."
  s.homepage             = "https://github.com/Brsoyan/Multiple-Selection-Picker"
  s.license              = 'MIT'
  s.author               = { "Brsoyan" => "haykbrsoyan@gmail.com" }
  s.source               = { :git => 'https://github.com/Brsoyan/Multiple-Selection-Picker', :tag => s.version }
  s.social_media_url     = "https://www.linkedin.com/in/hayk-brsoyan-33889871/"
  s.platform             = :ios, "9.0"  
  s.source_files         = "Sources/*.swift"
  s.exclude_files        = "Sources/Exclude"
  s.resources            = "Resources/*.png", "Resources/*.xib",
  s.swift_version        = "4.1"

  s.dependency 'SwiftyJSON', '4.1.0'


end
