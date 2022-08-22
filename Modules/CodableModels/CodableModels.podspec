Pod::Spec.new do |spec|

  spec.name         = "CodableModels"

  spec.version      = "0.0.1"

  spec.summary      = "A short description of CodableModels."

  spec.description  = <<-DESC

  Данный модуль содержит все модели участвующие в десериализации данных из сети

                   DESC

  spec.homepage     = "http://EXAMPLE/CodableModels"

  spec.license      = { :type => "MIT", :file => "LICENSE" }


  spec.author             = { "Vsevolod Pushin" => "pushin_95@mail.ru" }


 spec.source       = { :path => "." }

 spec.source_files  = "CodableModels/**/*.{h,m,swift,xib,storyboard}"

 spec.exclude_files = "Classes/Exclude"

 spec.ios.deployment_target = "12.1"

 spec.swift_version         = "5.0"

 spec.platform = :ios, "14.4" 


end
