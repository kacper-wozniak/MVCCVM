//
//  ReusableCell.swift
//  MVCCVM
//
//  Created by Kacper Woźniak on 08/10/2017.
//

protocol ReusableCell {}

extension ReusableCell {

    static var identifier: String { return String(describing: self) }

}
