source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '11.0'
use_frameworks!
inhibit_all_warnings!

# Shared

def shared_pods
  pod 'Firebase/Analytics'
  pod 'Firebase/RemoteConfig'
  pod 'SwinjectStateMachine', :git => 'https://github.com/0xPr0xy/SWinjectStateMachine.git'
  pod 'SwiftPin', :git => 'https://github.com/0xPr0xy/SwiftPin.git'
end

def shared_test_pods
  pod 'SwiftyMocky'
  pod 'Nimble'
end

# Targets

target 'Swoorn' do
  shared_pods
end

target 'SwoornTests' do
  shared_test_pods
  shared_pods
end

target 'SwoornSnapshotTests' do
  pod 'SnapshotTesting'
  shared_test_pods
  shared_pods
end

post_install do |installer|
  # Remove missing localizability warning for Pods
  installer.pods_project.build_configurations.each do |config|
    config.build_settings['CLANG_ANALYZER_LOCALIZABILITY_NONLOCALIZED'] = 'YES'
  end
end
