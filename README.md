# RxNetService

[![bitrise CI](https://img.shields.io/bitrise/ec02a90991a765cd?token=tFLkMNn-FUH_pVLLnJF4wA)](https://bitrise.io)
![platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS-lightgrey)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

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

Build and usage via swift package manager is supported:

### [Swift Package Manager](https://github.com/apple/swift-package-manager)

The easiest way to add the library is directly from within XCode (11). Alternatively you can create a `Package.swift` file. 

```swift
// swift-tools-version:5.0

import PackageDescription

let package = Package(
  name: "MyProject",
  dependencies: [
  .package(url: "https://github.com/katoemba/rxnetservice.git", from: "0.2.1")
  ],
  targets: [
    .target(name: "MyProject", dependencies: ["rxnetservice"])
  ]
)
```

## Author

Berrie Kremers, berrie at rigelian dot net

## License

RxNetService is available under the MIT license. See the LICENSE file for more info.

