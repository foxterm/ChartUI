Pod::Spec.new do |s|
  s.name             = 'ChartUI'
  s.version          = '0.1.0'
  s.summary          = 'ChartUI'
  s.description      = "ChartUI"
  s.homepage         = 'https://github.com/foxterm/ChartUI'
  s.license          = 'MIT'
  s.author           = { 'foxterm' => 'admin@foxterm.app' }
  s.source           = { :git => 'https://github.com/foxterm/ChartUI.git', :tag => s.version.to_s }
  s.ios.deployment_target = '17.0'
  s.osx.deployment_target = '14.0'
  s.swift_version = '5.10'
  s.source_files = ['Sources/**/*.{swift}']
  s.frameworks = 'Charts'
end
