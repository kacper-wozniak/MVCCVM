//
//  NavigationBar+Configuration.swift
//  MVCCVM
//
//  Created by Kacper Woźniak on 17/12/2017.
//

import UIKit

struct NavigationBarModel {

    let title: String?
    let leftButtonModel: ButtonModel?
    let rightButtonModel: ButtonModel?

    init(title: String? = nil, leftButtonModel: ButtonModel? = nil, rightButtonModel: ButtonModel? = nil) {
        self.title = title
        self.leftButtonModel = leftButtonModel
        self.rightButtonModel = rightButtonModel
    }

}

extension UIViewController {

    func configure(using model: NavigationBarModel) {
        title = model.title
        if let button = navigationItem.leftBarButtonItem {
            model.leftButtonModel.map { button.configure(using: $0) }
        } else {
            navigationItem.leftBarButtonItem = model.leftButtonModel.map { UIBarButtonItem(using: $0) }
        }
        if let button = navigationItem.rightBarButtonItem {
            model.rightButtonModel.map { button.configure(using: $0) }
        } else {
            navigationItem.rightBarButtonItem = model.rightButtonModel.map { UIBarButtonItem(using: $0) }
        }
    }

}
