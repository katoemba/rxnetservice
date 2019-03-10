//
//  ViewController.swift
//  RxNetService
//
//  Created by Berrie Kremers on 03/10/2019.
//  Copyright (c) 2019 Berrie Kremers. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxNetService

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let bag = DisposeBag()
    private let servicesSubject = PublishSubject<[NetService]>()
    private let httpNetServiceBrowser = NetServiceBrowser()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Create an observable that monitors when new players are discovered.
        httpNetServiceBrowser.rx.serviceAdded
            .map({ (service) -> [NetService] in
                [service]
            })
            .scan([]) { services, addedService in
                services + addedService
            }
            .bind(to: servicesSubject)
            .disposed(by: bag)
        
        // Create an observable that monitors when new players are removed from the network.
        httpNetServiceBrowser.rx.serviceRemoved
            .withLatestFrom(servicesSubject) { (removedService, services) -> [NetService] in
                services.filter({ (service) -> Bool in
                    service.name != removedService.name || service.port != removedService.port
                })
            }
            .bind(to: servicesSubject)
            .disposed(by: bag)

        // Bind the servicesSubject to a tableView
        servicesSubject
            .bind(to: tableView.rx.items(cellIdentifier: "NetServiceCell", cellType: UITableViewCell.self)) { (_, service, cell) in
                cell.textLabel?.text = service.name
                cell.detailTextLabel?.text = "\(service.hostName ?? "Unknown"):\(service.port)"
            }
            .disposed(by: bag)

        // Start looking for http servers
        httpNetServiceBrowser.searchForServices(ofType: "_http._tcp.", inDomain: "")
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

