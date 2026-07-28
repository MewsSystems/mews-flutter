#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint kiosk_mode.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'kiosk_mode'
  s.version          = '0.0.1'
  s.summary          = 'Plugin for working with Lock Task / Guided Access modes.'
  s.description      = <<-DESC
Plugin for working with Lock Task / Guided Access modes.
                       DESC
  s.homepage         = 'https://github.com/MewsSystems/mews-flutter'
  s.license          = { :type => 'BSD-3-Clause', :file => '../LICENSE' }
  s.author           = { 'Mews' => 'developers@mews.com' }
  s.source           = { :path => '.' }
  s.source_files = 'kiosk_mode/Sources/kiosk_mode/**/*.swift'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
