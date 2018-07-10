
Pod::Spec.new do |s|

  s.name         = "MultiPicker"
  s.version      = "0.0.1"
  s.summary      = "Picker View with multi row selection."
  s.description  = "description"
  s.homepage     = "http://EXAMPLE/MultiPicker"
  s.license      = { :type => "MIT", :file => "https://github.com/Brsoyan/Multiple-Selection-Picker/blob/master/LICENSE" }
  s.author             = { "Brsoyan" => "haykbrs@gmail.com" }
  s.social_media_url   = "http://twitter.com/Brsoyan"
  s.platform     = :ios, "9.0"  
  s.source_files  = "Source", "Classes/**/*.swift"
  s.exclude_files = "Source/Exclude"
  s.resources = "Source/*.png"
  s.framework  = "SwiftyJSON"

end
