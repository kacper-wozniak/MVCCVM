//
//  TaskListViewModel.swift
//  MVCCVM
//
//  Created by Kacper Woźniak on 08/10/2017.
//

import Foundation

enum TaskListViewModelAction {

    case create
    case show(Task)

}

enum TaskListViewModelChange {

    case reloadList
    case deleteItem(IndexPath)

}

final class TaskListViewModel {

    var detected: ((TaskListViewModelAction) -> ())?
    var changed: ((TaskListViewModelChange) -> ())?

    lazy var navigationBarModel: NavigationBarModel = {
        return NavigationBarModel(title: "MVCCVM",
                                  rightButtonModel: ButtonModel(asset: "plus",
                                                                action: { [weak self] in self?.detected?(.create) }))
    }()

    let taskManager: TaskManager

    init(taskManager: TaskManager) {
        self.taskManager = taskManager
    }

    let numberOfSections: Int = 1

    func numberOfItems(in section: Int) -> Int {
        return taskManager.tasks.count
    }

    func cellModel(at indexPath: IndexPath) -> TaskCellModelProtocol {
        return TaskCellModel(task: taskManager.tasks[indexPath.item])
    }
    
    func cellDeleted(at indexPath: IndexPath) {
        taskManager.tasks.remove(at: indexPath.item)
        changed?(.deleteItem(indexPath))
    }
    
    func cellTapped(at indexPath: IndexPath) {
        detected?(.show(taskManager.tasks[indexPath.item]))
    }

}
