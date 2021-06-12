//  
//  UserHomeController.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 13.05.21.
//

import UIKit
import Core
import MaterialComponents.MDCOutlinedTextField
import NotificationBannerSwift

class UserHomeController: UIViewController {

    @IBOutlet weak var scanButton: MDCButton!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: UserHomePresenter!

    @IBAction func scanDidTap(_ sender: MDCButton) {
        presenter.didTapScan()
    }
    
}

extension UserHomeController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(with: "GreetingCell", type: GreetingCell.self)
        tableView.registerNib(with: "PersonalInfoCell", type: PersonalInfoCell.self)
        tableView.registerNib(with: "TitleCell", type: TitleCell.self)
        tableView.registerNib(with: "JoinOrganizationCell", type: JoinOrganizationCell.self)
        tableView.registerNib(with: "MyOrganizationCell", type: MyOrganizationCell.self)
        
        scanButton.setTitle("Scan Number Plate", for: .normal)
        scanButton.setTitleColor(.white, for: .normal)
        scanButton.setTitleFont(UIFont(name: "Futura", size: 14), for: .normal)
        scanButton.setBackgroundColor(.black)
        scanButton.layer.cornerRadius = 16
        scanButton.setElevation(.raisedButtonResting, for: .normal)
        
        presenter.viewDidLoad()
    }
    
}


// MARK: UITableViewDelegate
extension UserHomeController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //presenter.didSelectItem(at: indexPath.row)
    }
    
}

// MARK: UITableViewDataSource
extension UserHomeController: UITableViewDataSource {
    
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
    
}

extension UserHomeController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let capturedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            presenter.didSelectFromGallery(photo: capturedImage)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func showBanner(title: String?, subtitle: String, style: BannerStyle) {
        let banner = NotificationBanner(
            title: title,
            subtitle: subtitle,
            style: style
        )
        banner.show()
    }
    
}

extension UserHomeController {
    
    static func configured(with user: User, organization: Organization?) -> UserHomeController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "UserHomeController") as! UserHomeController
        let configurator = UserHomeConfiguratorImpl()
        configurator.configure(vc, user: user, organization: organization)
        return vc
    }
    
}

extension UserHomeController: UserHomeView {
    
    var scanButtonIsEnabled: Bool {
        get { scanButton.isEnabled }
        set { scanButton.setEnabled(newValue, animated: true) }
    }
    
    
    func showImageSourceSelectionSheet(didSelectCamera: @escaping () -> Void, didSelectGallery: @escaping () -> Void) {
        let alert = UIAlertController(title: "Image Source Selection", message: "Please select an option below", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ _ in
            didSelectCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default , handler:{ _ in
            didSelectGallery()
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))

        
        self.present(alert, animated: true, completion: nil)
    }
    
}

