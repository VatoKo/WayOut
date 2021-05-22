//
//  CellConfiguration.swift
//  WayOut
//
//  Created by Vakhtang Kostava on 13.05.21.
//

import Foundation

protocol CellViewModel {
    func configure(with model: CellModel)
}


protocol CellModel {
    var cellIdentifier: String { get }
}
