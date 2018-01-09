//
//  UIButton+Configuration.swift
//  MVCCVM
//
//  Created by Kacper Woźniak on 08/01/2018.
//

import UIKit

struct ButtonModel {

    let title: String?
    let asset: String?
    let isEnabled: Bool
    let action: () -> Void

    init(title: String? = nil, asset: String? = nil, isEnabled: Bool = true, action: @escaping () -> Void) {
        self.title = title
        self.asset = asset
        self.isEnabled = isEnabled
        self.action = action
    }

}

typealias ButtonAction = () -> Void
class ButtonActionWrapper: NSObject {
    let action: ButtonAction
    init(_ action: @escaping ButtonAction) {
        self.action = action
        super.init()
    }
}

extension UIButton {

    private struct Key {
        static var action = "action"
    }

    func setAction(_ action: @escaping ButtonAction) {
        objc_setAssociatedObject(self, &Key.action, ButtonActionWrapper(action), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        addTarget(self, action: #selector(performAction), for: .touchUpInside)
    }

    @objc private func performAction() {
        (objc_getAssociatedObject(self, &Key.action) as? ButtonActionWrapper)?.action()
    }

    convenience init(using model: ButtonModel) {
        self.init()
        configure(using: model)
    }

    func configure(using model: ButtonModel) {
        isEnabled = model.isEnabled
        model.title.map { setTitle($0, for: .normal) }
        model.asset.map { setImage(UIImage(named: $0), for: .normal) }
        setAction(model.action)
    }

}

extension UIBarButtonItem {

    private struct Key {
        static var action = "action"
    }

    func setAction(_ action: @escaping ButtonAction) {
        objc_setAssociatedObject(self, &Key.action, ButtonActionWrapper(action), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        self.target = self
        self.action = #selector(performAction)
    }

    @objc private func performAction() {
        (objc_getAssociatedObject(self, &Key.action) as? ButtonActionWrapper)?.action()
    }

    convenience init(using model: ButtonModel) {
        self.init()
        configure(using: model)
    }

    func configure(using model: ButtonModel) {
        title = model.title
        image = model.asset.map { UIImage(named: $0) } ?? nil
        isEnabled = model.isEnabled
        setAction(model.action)
    }

}
