Pod::Spec.new do |s|
  s.name             = 'imitate'
  s.version          = '1.0.1'
  s.summary          = 'This is not a meaningful summary'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/damian-rzeszot/mocker'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Damian Rzeszot' => 'damian.rzeszot@gmail.com' }
  s.source           = { :git => 'https://github.com/damian.rzeszot/mocker.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'

  s.swift_version = '5.0'
  s.source_files = 'Source/Mocker/**/*.swift'
end
