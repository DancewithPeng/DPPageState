#
#  Be sure to run `pod spec lint DPFlowCoordinator.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name = 'DPPageState'
  s.version = '1.0'
  s.license = 'MIT'
  s.summary = '页面状态切换实现，方便切换各种页面状态'
  s.homepage = 'http://www.dpdev.cn'
  s.authors = { 'DancewithPeng' => 'dancewithpeng@gmail.com' }
  s.source = { :git => 'https://github.com/DancewithPeng/DPPageState.git', :tag => s.version }

  s.platform = :ios, '9.0'

  #s.ios.deployment_target = '8.0'
  #s.osx.deployment_target = '10.10'
  #s.tvos.deployment_target = '9.0'
  #s.watchos.deployment_target = '2.0'

  s.source_files = 'DPPageState/DPPageState/Source/*.swift'
  s.swift_version  = '4.0'
end
