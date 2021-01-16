# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'TMDbApp' do
  use_frameworks!
  pod 'SDWebImage'
end
  
def network_service
  pod 'Alamofire'
end

target 'TMDbNetworkService' do
  workspace 'TMDbApp'
  project 'TMDbNetworkService/TMDbNetworkService.xcodeproj'
  use_frameworks!
  
  network_service
end

target 'TMDbComponents' do
  workspace 'TMDbApp'
  project 'TMDbComponents/TMDbComponents.xcodeproj'
  use_frameworks!
  
end

target 'TMDbUtilities' do
  workspace 'TMDbApp'
  project 'TMDbUtilities/TMDbUtilities.xcodeproj'
  use_frameworks!
  
end
