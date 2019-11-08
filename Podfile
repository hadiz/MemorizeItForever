# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'
workspace 'MemorizeItForever.xcworkspace'

# ignore all warnings from all pods
inhibit_all_warnings!

def shared_pods
    pod 'Swinject'
end

target 'MemorizeItForever' do
    project 'MemorizeItForever/MemorizeItForever.xcodeproj'
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    
    use_frameworks!
    
    # Pods for MemorizeItForever
    
    shared_pods
    pod 'SwinjectStoryboard'
    pod 'Firebase/MLVisionTextModel'

    target 'MemorizeItForeverTests' do
        inherit! :search_paths
        # Pods for testing
    end
    
    target 'MemorizeItForeverUITests' do
        inherit! :search_paths
        # Pods for testing
    end
    
end

target 'MemorizeItForeverCore' do
    project 'MemorizeItForeverCore/MemorizeItForeverCore.xcodeproj'
    
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    
    use_frameworks!
    
    # Pods for MemorizeItForeverCore
    
    shared_pods
    
    target 'MemorizeItForeverCoreTests' do
        inherit! :search_paths
        # Pods for testing
    end
    
end
