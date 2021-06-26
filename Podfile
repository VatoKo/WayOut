# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

use_frameworks!

workspace 'WayOut'

#Core Module
def core_pods
  pod 'Firebase/Auth'
  pod 'Firebase/Database'
end

target 'Core' do
  project 'Core/Core.project'
  core_pods
end



#WayOutManager Module
def wayout_manager_pods
  core_pods
end

target 'WayOutManager' do
  project 'WayOutManager/WayOutManager.project'
  wayout_manager_pods
  pod 'MaterialComponents/TextControls+OutlinedTextFields'
  pod 'MaterialComponents/Buttons'
  pod 'NotificationBannerSwift', '~> 3.0.0'
end



#WayOut
def wayout_pods
  core_pods
  wayout_manager_pods
  pod 'MaterialComponents/TextControls+OutlinedTextFields'
  pod 'MaterialComponents/Buttons'
  pod 'NotificationBannerSwift', '~> 3.0.0'
end


target 'WayOut' do
  wayout_pods
end
