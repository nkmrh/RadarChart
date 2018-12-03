Pod::Spec.new do |s|
  s.name          = "RadarChart"
  s.version       = "1.0.0"
  s.summary       = "A lightweight and simple to use radar chart."
  s.homepage      = "https://github.com/nkmrh/RadarChart"
  s.license       = { :type => "MIT", :file => "LICENSE" }
  s.author        = { "Hajime Nakamura" => "nkmrhj@gmail.com" }
  s.social_media_url = "http://twitter.com/_nkmrh"
  s.platform      = :ios, "9.0"
  s.source        = { :git => "https://github.com/nkmrh/RadarChart.git", :tag => s.version }
  s.source_files  = "RadarChart/*.swift"
  s.swift_version = '4.2'
end
