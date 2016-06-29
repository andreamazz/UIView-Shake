desc "Run the test suite"

task :test do
  build = "xcodebuild \
    -workspace Sample/Sample.xcworkspace \
    -scheme Sample \
    -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 6s,OS=9.3'"
  system "#{build} test | xcpretty --test --color"  
end

task :default => :test

