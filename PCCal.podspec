Pod::Spec.new do |s|
  s.name = "PCCal"
  s.version = "1.0.0"
  s.summary = "A simple week view calendar widget."
  s.homepage = "https://github.com/pierredavidbelanger/PCCal"
  s.license = 'MIT'
  s.author = { "Pierre-David Bélanger" => "pierredavidbelanger@gmail.com" }
  s.source = { :git => "https://github.com/pierredavidbelanger/PCCal.git", :tag => s.version.to_s }
  s.requires_arc = true
  s.source_files = 'PCCal/*.{h,m}'
  s.public_header_files = 'PCCal/*.h'
  s.private_header_files = 'PCCal/*+Private.h'
  s.resource_bundles = { 'PCCal' => 'PCCal/*.xib' }
  s.ios.deployment_target = '7.0'
end