# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'TMDbApp' do
  use_frameworks!
  pod 'SDWebImage'
end
  
def network_service
  pod 'Alamofire'
end

target 'NetworkService' do
  workspace 'TMDbApp'
  project 'NetworkService/NetworkService.xcodeproj'
  use_frameworks!
  
  network_service
end
