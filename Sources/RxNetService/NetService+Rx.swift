//
//  RxNetService.swift
//  MPDConnector_iOS
//
// The MIT License (MIT)
//
// Copyright (c) 2018 Katoemba Software
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import Foundation
import RxSwift
import RxCocoa

extension NetService: HasDelegate {
    public typealias Delegate = NetServiceDelegate
}

public class RxNetServiceDelegateProxy
    : DelegateProxy<NetService, NetServiceDelegate>
    , DelegateProxyType
    , NetServiceDelegate {
    
    /// Typed parent object.
    public weak private(set) var netService: NetService?
    
    /// - parameter pickerView: Parent object for delegate proxy.
    public init(netService: ParentObject) {
        self.netService = netService
        super.init(parentObject: netService, delegateProxy: RxNetServiceDelegateProxy.self)
    }
    
    // Register known implementationss
    public static func registerKnownImplementations() {
        self.register { RxNetServiceDelegateProxy(netService: $0) }
    }
}

public extension Reactive where Base: NetService {
    var delegate: DelegateProxy<NetService, NetServiceDelegate> {
        return RxNetServiceDelegateProxy.proxy(for: base)
    }
    
    /// Installs delegate as forwarding delegate on `delegate`.
    /// Delegate won't be retained.
    ///
    /// It enables using normal delegate mechanism with reactive delegate mechanism.
    ///
    /// - parameter delegate: Delegate object.
    /// - returns: Disposable object that can be used to unbind the delegate.
    func setDelegate(_ delegate: NetServiceDelegate)
        -> Disposable {
            return RxNetServiceDelegateProxy.installForwardDelegate(delegate, retainDelegate: false, onProxyForObject: self.base)
    }
    
    var didResolveAddress: Observable<NetService> {
        return delegate
            .methodInvoked(#selector(NetServiceDelegate.netServiceDidResolveAddress(_:)))
            .map { params in
                return params[0] as! NetService                
            }
    }

    func resolve(withTimeout timeout: TimeInterval) -> Observable<NetService> {
        let netService = self.base as NetService
        netService.resolve(withTimeout: timeout)
        return didResolveAddress.filter {
                $0 == self.base
            }
    }
}

public extension NetService {
    var firstIPv4Address: String? {
        firstAddress(containing: ".")
    }

    var firstIPv6Address: String? {
        firstAddress(containing: ":")
    }

    func firstAddress(containing: String) -> String? {
        guard let addresses = addresses else { return nil }
        for address in addresses {
            if let ip = address.withUnsafeBytes({ pointer -> String? in
                var hostStr = [Int8](repeating: 0, count: Int(NI_MAXHOST))
                
                let result = getnameinfo(
                    pointer.baseAddress?.assumingMemoryBound(to: sockaddr.self),
                    socklen_t(address.count),
                    &hostStr,
                    socklen_t(hostStr.count),
                    nil,
                    0,
                    NI_NUMERICHOST
                )
                guard result == 0 else { return nil }
                return String(cString: hostStr)
            }) {
                if ip.contains(containing) {
                    return ip
                }
            }
        }
        
        return nil
    }
}
