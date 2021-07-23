//  
//  OrganizationHomeController.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 26.06.21.
//

import UIKit
import Core
import NotificationBannerSwift

public class OrganizationHomeController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: OrganizationHomePresenter!

    
}

extension OrganizationHomeController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(with: "GreetingCell", type: GreetingCell.self)
        tableView.registerNib(with: "MyOrganizationCell", type: MyOrganizationCell.self)
        tableView.registerNib(with: "TitleCell", type: TitleCell.self)
        tableView.registerNib(with: "MemberCell", type: MemberCell.self)
        tableView.registerNib(with: "NoMembersCell", type: NoMembersCell.self)
        
        presenter.viewDidLoad()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}

// MARK: UITableViewDelegate
extension OrganizationHomeController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

// MARK: UITableViewDataSource
extension OrganizationHomeController: UITableViewDataSource {
    
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

extension OrganizationHomeController: OrganizationHomeView {
    
    func showBanner(title: String?, subtitle: String, style: BannerStyle) {
        let banner = NotificationBanner(
            title: title,
            subtitle: subtitle,
            style: style
        )
        banner.show()
    }
    
    func reloadList() {
        tableView.reloadData()
    }
    
}

extension OrganizationHomeController {
    
    public static func configured(organization: Organization, members: [User]) -> OrganizationHomeController {
        let storyboard = UIStoryboard(name: "ManagerMain", bundle: Bundle(identifier: "WayOut.WayOutManager"))
        let vc = storyboard.instantiateViewController(identifier: "OrganizationHomeController") as! OrganizationHomeController
        let configurator = OrganizationHomeConfiguratorImpl()
        configurator.configure(vc, organization: organization, members: members)
        return vc
    }
    
}

