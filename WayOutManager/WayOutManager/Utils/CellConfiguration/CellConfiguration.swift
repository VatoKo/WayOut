//
//  CellConfiguration.swift
//  WayOutManager
//
//  Created by Vakhtang Kostava on 26.06.21.
//

import Foundation

protocol CellViewModel {
    func configure(with model: CellModel)
}


protocol CellModel {
    var cellIdentifier: String { get }
}
