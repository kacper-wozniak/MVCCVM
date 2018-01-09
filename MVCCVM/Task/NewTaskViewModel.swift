//
//  NewTaskViewModel.swift
//  MVCCVM
//
//  Created by Kacper Woźniak on 17/12/2017.
//

final class NewTaskViewModel: TaskViewModelProtocol {

    var detected: ((TaskViewModelAction) -> ())?
    var changed: ((TaskViewModelChange) -> ())?

    let taskManager: TaskManager
    let task = Task(name: "", description: "")

    var name: String {
        get { return task.name }
        set {
            task.name = newValue
            changed?(.navigationBar(navigationBarModel))
        }
    }
    var description: String {
        get { return task.description }
        set {
            task.description = newValue
            changed?(.navigationBar(navigationBarModel))
        }
    }

    init(taskManager: TaskManager) {
        self.taskManager = taskManager
    }

    var navigationBarModel: NavigationBarModel {
        return NavigationBarModel(title: "New Task",
                                  leftButtonModel: ButtonModel(asset: "close",
                                                               action: { [weak self] in self?.detected?(.close) }),
                                  rightButtonModel: ButtonModel(asset: "accept",
                                                                isEnabled: !name.isEmpty && !description.isEmpty,
                                                                action: { [weak self] in self?.add() }))
    }

    func add() {
        taskManager.tasks.append(task)
        detected?(.close)
    }

    func setup() {
        changed?(.name(name))
        changed?(.description(description))
        changed?(.navigationBar(navigationBarModel))
        changed?(.editMode(true))
    }

}
