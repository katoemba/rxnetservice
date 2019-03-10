# RxNetService

[![Version](https://img.shields.io/cocoapods/v/RxNetService.svg?style=flat)](https://cocoapods.org/pods/RxNetService)
[![License](https://img.shields.io/cocoapods/l/RxNetService.svg?style=flat)](https://cocoapods.org/pods/RxNetService)
[![Platform](https://img.shields.io/cocoapods/p/RxNetService.svg?style=flat)](https://cocoapods.org/pods/RxNetService)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Code Snippet

```
//
// Newly discovered services are posted on an Observable sequence:
//
let httpNetServiceBrowser = NetServiceBrowser()
httpNetServiceBrowser.rx.serviceAdded
	.subscribe(onNext: { (service) in
		print("Found player \(service.name)")
	})
	.disposed(by: bag)
			
httpNetServiceBrowser.searchForServices(ofType: "_http._tcp.", inDomain: "")
```


## Requirements

This library depends on RxSwift and RxCocoa.

## Installation

RxNetService is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RxNetService'
```

## Author

Berrie Kremers, berrie@rigelian.net

## License

RxNetService is available under the MIT license. See the LICENSE file for more info.
