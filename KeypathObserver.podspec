Pod::Spec.new do |s|

  s.name        = "KeypathObserver"
  s.version     = "1.0.0"
  s.summary     = "Make KVO observing easier."

  s.description = <<-DESC
                   KVO observing with simple syntax.
                   DESC

  s.homepage    = "https://github.com/nixzhu/KeypathObserver"

  s.license     = { :type => "MIT", :file => "LICENSE" }

  s.authors           = { "nixzhu" => "zhuhongxu@gmail.com" }
  s.social_media_url  = "https://twitter.com/nixzhu"

  s.ios.deployment_target       = "8.0"
  s.osx.deployment_target       = "10.10"
  s.tvos.deployment_target      = "9.0"
  s.watchos.deployment_target   = "2.0"

  s.source          = { :git => "https://github.com/nixzhu/KeypathObserver.git", :tag => s.version }
  s.source_files    = ["Sources/*.swift", "KeypathObserver/KeypathObserver.h"]
  s.public_header_files = ["KeypathObserver/KeypathObserver.h"]

  s.requires_arc    = true

end
