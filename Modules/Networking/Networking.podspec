Pod::Spec.new do |spec|

  spec.name         = "Networking"

  spec.version      = "0.0.1"

  spec.summary      = "A short description of Networking."

  spec.description  = <<-DESC

Данный модуль содержит в себе NetworkingService который получает данные из сети

                   DESC

  spec.homepage     = "http://EXAMPLE/Networking"

  spec.license      = { :type => "MIT", :file => "LICENSE" }


  spec.author             = { "Vsevolod Pushin" => "pushin_95@mail.ru" }


 spec.source       = { :path => "." }

 spec.source_files  = "Networking/**/*.{h,m,swift,xib,storyboard}"

 spec.dependency      "CodableModels"

 spec.exclude_files = "Classes/Exclude"

 spec.ios.deployment_target = "12.1"

 spec.swift_version         = "5.0"

 spec.platform = :ios, "14.4" 


end
