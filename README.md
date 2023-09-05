# CXLogger

[![CI Status](https://img.shields.io/travis/shenchunxing/CXLogger.svg?style=flat)](https://travis-ci.org/shenchunxing/CXLogger)
[![Version](https://img.shields.io/cocoapods/v/CXLogger.svg?style=flat)](https://cocoapods.org/pods/CXLogger)
[![License](https://img.shields.io/cocoapods/l/CXLogger.svg?style=flat)](https://cocoapods.org/pods/CXLogger)
[![Platform](https://img.shields.io/cocoapods/p/CXLogger.svg?style=flat)](https://cocoapods.org/pods/CXLogger)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	//开启日志
    [[CXLoggerManager shareManager] startLogger];
    return YES;
}
```

## Requirements

## Installation

CXLogger is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CXLogger'
```

## Author

shenchunxing, 519045026@qq.com

## License

CXLogger is available under the MIT license. See the LICENSE file for more info.
