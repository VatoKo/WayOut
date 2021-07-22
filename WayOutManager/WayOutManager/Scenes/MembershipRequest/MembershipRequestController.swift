//  
//  MembershipRequestController.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 20.07.21.
//

import UIKit
import Core

class MembershipRequestController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MembershipRequestPresenter!

    
}

extension MembershipRequestController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = .init(top: 16, left: .zero, bottom: .zero, right: .zero)
        tableView.registerNib(with: "MembershipRequestCell", type: MembershipRequestCell.self)
        presenter.viewDidLoad()
    }
    
}

// MARK: UITableViewDelegate
extension MembershipRequestController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

// MARK: UITableViewDataSource
extension MembershipRequestController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.tableDataSource.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = presenter.tableDataSource[indexPath.row]
        let dequeued = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier, for: indexPath)
        let cell = dequeued as! CellViewModel
        cell.configure(with: model)
        return dequeued
    }
    
}

extension MembershipRequestController: MembershipRequestView {
    
    func reloadList() {
        tableView.reloadData()
    }
    
}

extension MembershipRequestController {
    
    public static func configured(organization: Organization) -> MembershipRequestController {
        let storyboard = UIStoryboard(name: "ManagerMain", bundle: Bundle(identifier: "WayOut.WayOutManager"))
        let vc = storyboard.instantiateViewController(identifier: "MembershipRequestController") as! MembershipRequestController
        let configurator = MembershipRequestConfiguratorImpl()
        configurator.configure(vc, organization: organization)
        return vc
    }
    
}

