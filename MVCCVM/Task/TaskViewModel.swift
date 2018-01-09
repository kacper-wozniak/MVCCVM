//
//  TaskViewModel.swift
//  MVCCVM
//
//  Created by Kacper Woźniak on 15/10/2017.
//

final class TaskViewModel: TaskViewModelProtocol {

    var detected: ((TaskViewModelAction) -> ())?
    var changed: ((TaskViewModelChange) -> ())?

    let task: Task

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

    init(task: Task) {
        self.task = task
    }

    var isEditing: Bool = false

    var navigationBarModel: NavigationBarModel {
        return NavigationBarModel(title: "Details",
                                  leftButtonModel: isEditing ? nil : ButtonModel(asset: "back",
                                                                                 action: { [weak self] in self?.detected?(.close) }),
                                  rightButtonModel: ButtonModel(asset: isEditing ? "accept" : "edit",
                                                                isEnabled: !name.isEmpty && !description.isEmpty,
                                                                action: { [weak self] in self?.toggleEditMode() }))
    }

    func toggleEditMode() {
        isEditing = !isEditing
        changed?(.editMode(isEditing))
        changed?(.navigationBar(navigationBarModel))
    }

    func setup() {
        changed?(.name(name))
        changed?(.description(description))
        changed?(.navigationBar(navigationBarModel))
    }
    
}
