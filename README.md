# DKFLEXLoader

Script and CydiaSubstrate tweak which helps to build [FLEX](https://github.com/Flipboard/FLEX) .dylib and inject it into the system and 3rd-party apps. Requires [Theos](https://theos.dev/docs/installation-macos).

#### How-to

1. `xcodebuild -project FLEX/FLEX.xcodeproj -target FLEX`
2. `make && make package`
3. `make install`

#### Some screenshots
![Preferences](Screenshots/Preferences.png)
![Weather.app](Screenshots/Weather.png)
