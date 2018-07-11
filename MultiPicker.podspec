
Pod::Spec.new do |s|

  s.name                 = "MultiPicker"
  s.version              = "0.0.2"
  s.summary              = "Picker View with multi row selection."
  s.homepage             = "https://github.com/Brsoyan/Multiple-Selection-Picker"
  s.license              = 'MIT'
  s.author               = { "Brsoyan" => "haykbrs@gmail.com" }
  s.source               = { :git => 'https://github.com/Brsoyan/Multiple-Selection-Picker', :tag => s.version }
  s.social_media_url     = "http://twitter.com/Brsoyan"
  s.platform             = :ios, "9.0"  
  s.source_files         = "Sources/*.swift"
  s.exclude_files        = "Sources/Exclude"
  s.resources            = "Resources/*.png", "Resources/*.xib",
  s.swift_version        = "4.1"

  s.dependency 'SwiftyJSON', '4.1.0'


end
