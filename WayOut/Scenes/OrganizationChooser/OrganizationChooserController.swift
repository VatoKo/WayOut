//  
//  OrganizationChooserController.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 12.06.21.
//

import UIKit
import NotificationBannerSwift
import MaterialComponents.MDCOutlinedTextField

class OrganizationChooserController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchField: MDCOutlinedTextField!
    
    var presenter: OrganizationChooserPresenter!

    
    @IBAction func didTapClose(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editingChanged(_ sender: MDCOutlinedTextField) {
        presenter.searchValue = sender.text ?? String()
    }
    
    
}

// MARK: UIViewController Lifecycle
extension OrganizationChooserController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        view.addGestureRecognizer(tapGesture)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(with: "MyOrganizationCell", type: MyOrganizationCell.self)
        
        searchField.label.text = "Search"
        
        presenter.viewDidLoad()
    }
    
}

// MARK: UITableViewDelegate
extension OrganizationChooserController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //presenter.didSelectItem(at: indexPath.row)
    }
    
}

// MARK: UITableViewDataSource
extension OrganizationChooserController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.tableDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = presenter.tableDataSource[indexPath.row]
        let dequeued = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier, for: indexPath)
        let cell = dequeued as! CellViewModel
        cell.configure(with: model)
        return dequeued
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

extension OrganizationChooserController: OrganizationChooserView {
    
    func showPopup(title: String, subtitle: String, completion: @escaping () -> Void) {
        let popup = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        popup.addAction(.init(title: "No", style: .cancel, handler: nil))
        popup.addAction(.init(title: "Yes", style: .default, handler: { _ in
            completion()
        }))
        present(popup, animated: true, completion: nil)
    }
    
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

// MARK: Touch Events
extension OrganizationChooserController {
    
    @objc
    private func didTapView() {
        view.endEditing(true)
    }
    
}

extension OrganizationChooserController: Configurable {
    
    static func configured() -> OrganizationChooserController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "OrganizationChooserController") as! OrganizationChooserController
        let configurator = OrganizationChooserConfiguratorImpl()
        configurator.configure(vc)
        return vc
    }

}

