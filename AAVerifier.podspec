Pod::Spec.new do |s|
          #1.
          s.name               = "AAVerifier"
          #2.
          s.version            = "1.2.3"
          #3.  
          s.summary         = "impliment Your Code Verify with Simple Way"
          #4.
          s.homepage        = "https://github.com/amir-ardalanuk/AAVerifier"
          #5.
          s.license              = "MIT"
          #6.
          s.author               = "Amir Ardalan"
          #7.
          s.platform            = :ios, "10.0"
          #8.
          s.source              = { :git => "https://github.com/amir-ardalanuk/AAVerifier.git", :tag => "1.2.3" }
          #9.
          s.source_files       = "AAVerifier/AAVerifier/*"
          #10.
          s.exclude_files     = "AAVerifier/AAVerifier/*.plist"
          #11.
          swift_version       = "4.2"
       
    end
