#
# Be sure to run `pod lib lint RxNetService.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RxNetService'
  s.version          = '0.1.1'
  s.summary          = 'A reactive extension to NetServiceBrowser.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
The RxNetService provides an rx extension to the standard NetServiceBrowser class with 2 new observable sequences:
serviceAdded and serviceRemoved.
                       DESC

  s.homepage         = 'https://bitbucket.org/katoemba/rxnetservice'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Berrie Kremers' => 'berrie@rigelian.net' }
  s.source           = { :git => 'https://bitbucket.org/katoemba/rxnetservice', :tag => '0.1.1' }

  s.swift_version = '5.0'
  s.ios.deployment_target = '9.3'

  s.source_files = 'RxNetService/Classes/**/*'
  
  # s.resource_bundles = {
  #   'RxNetService' => ['RxNetService/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'RxSwift', '~> 4.5'
  s.dependency 'RxCocoa', '~> 4.5'
end
