//
//  AppCoordinator.swift
//  MVCCVM
//
//  Created by Kacper Woźniak on 08/10/2017.
//

import UIKit

final class AppCoordinator: Coordinator {

    init() {
        let viewController = TaskListViewController()
        super.init(viewController: UINavigationController(rootViewController: viewController))
        let viewModel = TaskListViewModel(taskManager: TaskManager.instance)
        viewController.viewModel = viewModel
        viewModel.detected = { [weak self] action in
            switch action {
            case .create: self?.createTask()
            case .show(let task): self?.show(task: task)
            }
        }
    }

    func createTask() {
        let viewController = TaskViewController()
        let viewModel = NewTaskViewModel(taskManager: TaskManager.instance)
        viewModel.detected = { [weak self] action in
            switch action {
            case .close: self?.navigationController?.dismiss(animated: true)
            }
        }
        viewController.viewModel = viewModel
        navigationController?.present(UINavigationController(rootViewController: viewController), animated: true)
    }

    func show(task: Task) {
        let viewController = TaskViewController()
        let viewModel = TaskViewModel(task: task)
        viewModel.detected = { [weak self] action in
            switch action {
            case .close: self?.navigationController?.popViewController(animated: true)
            }
        }
        viewController.viewModel = viewModel
        navigationController?.pushViewController(viewController, animated: true)
    }

}
