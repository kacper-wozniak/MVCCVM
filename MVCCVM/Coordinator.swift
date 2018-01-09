//
//  Coordinator.swift
//  MVCCVM
//
//  Created by Kacper Woźniak on 08/10/2017.
//

import UIKit

enum PresentationStyle {

    case push
    case modal
    case root
    case none

}

class Coordinator: NSObject {

    private final weak var supercoordinator: Coordinator?
    private final var subcoordinators = Set<Coordinator>()
    private final var presentationStyle: PresentationStyle = .none

    final let viewController: UIViewController

    final var navigationController: UINavigationController? {
        return  viewController as? UINavigationController ??
                viewController.navigationController ??
                supercoordinator?.viewController.navigationController
    }

    final func start(coordinator: Coordinator? = nil) {
        if let coordinator = coordinator {
            subcoordinators.insert(coordinator)
        }
        coordinator?.navigationController?.delegate = coordinator
    }

    final func start(coordinator: Coordinator,
                     with style: PresentationStyle = .push) {
        coordinator.presentationStyle = style
        switch style {
        case .push:
            navigationController?.pushViewController(coordinator.viewController, animated: true)
        case .modal:
            let navigation = UINavigationController(rootViewController: coordinator.viewController)
            navigationController?.present(navigation, animated: true, completion: nil)
        case .root:
            navigationController?.delegate = coordinator
            navigationController?.setViewControllers([coordinator.viewController], animated: true)
            subcoordinators.removeAll()
        case .none: break
        }
        start(coordinator: coordinator)
    }

    init(viewController: UIViewController = UINavigationController(), supercoordinator: Coordinator? = nil) {
        self.supercoordinator = supercoordinator
        self.viewController = viewController
        super.init()
    }

    final func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        let finalize = { [weak self] in
            completion?()
            self?.subcoordinators.removeAll()
            self?.removeFromSupercoordinator()
        }
        switch presentationStyle {
        case .push:
            navigationController?.popViewController(animated: animated)
            finalize()
        case .modal:
            navigationController?.dismiss(animated: animated, completion: {
                finalize()
            })
        default: finalize()
        }
    }

    private final func pop(coordinator: Coordinator) {
        subcoordinators.remove(coordinator)
        coordinator.navigationController?.delegate = self
    }

    private final func findCoordinator(for viewController: UIViewController) -> Coordinator? {
        weak var supercoordinator: Coordinator? = self.supercoordinator
        while let coordinator = supercoordinator {
            if viewController === coordinator.viewController {
                return coordinator
            }
            supercoordinator = coordinator.supercoordinator
        }
        return nil
    }

    private func removeFromSupercoordinator() {
        supercoordinator?.pop(coordinator: self)
    }

}

extension Coordinator: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        if let coordinator = findCoordinator(for: viewController) {
            coordinator.subcoordinators.removeAll()
        }
    }

}
