//
//  ViewController.swift
//  CanadaPOC
//
//  Created by Admin on 3/26/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var service : DataService! = DataService() // network service object
    let dataSource = FeedsDataSource() // for table datasource object
    lazy var viewModel : FeedsViewModel = {
        let viewModel = FeedsViewModel(service: service, dataSource: dataSource)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableView.dataSource = self.dataSource
        //Binding tableView
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.tableView.reloadData()
        }
        
        self.setupUI()
        self.setupUIRefreshControl()
        // Fetching data from server
        self.serviceCall()
        
    }
    // refresh controle added
    func setupUIRefreshControl(){
        refreshControl.addTarget(self, action: #selector(serviceCall), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
        
    }
    
    // fetching Request
    // in closure result is sucess then recevied the model data
    // in closure result is fail - fetch is fail
    @objc func serviceCall() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            self.viewModel.fetchServiceCall { result in
                switch result {
                case .success :
                    self.title = self.viewModel.title
                    break
                case .failure :
                    break
                }
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
        refreshControl.endRefreshing()
    }


}

extension ViewController {
    func setupUI() {
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(serviceCall))
    }
}

// table delegate method implement

extension ViewController : UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
