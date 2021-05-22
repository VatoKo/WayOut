//
//  Reusable.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 13.05.21.
//

import UIKit

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Reusable where Self: UIView {
    
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
    
}

extension UITableViewCell: Reusable {
    
}

extension UITableView {
    
    func register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerNib<T: UITableViewCell>(with nibName: String, type: T.Type) {
        register(.init(nibName: nibName, bundle: nil), forCellReuseIdentifier: T.reuseIdentifier)
    }

}
