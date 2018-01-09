//
//  TableView+ReusableCell.swift
//  MVCCVM
//
//  Created by Kacper Woźniak on 08/10/2017.
//

import UIKit

extension UITableView {

    func register(cell: ReusableCell.Type) {
        let nib = UINib(nibName: cell.identifier, bundle: nil)
        register(nib, forCellReuseIdentifier: cell.identifier)
    }

    func dequeue<Cell: ReusableCell>(cell: Cell.Type) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: Cell.identifier) as? Cell else {
            fatalError("\(Cell.identifier) must be registered.")
        }
        return cell
    }

}
