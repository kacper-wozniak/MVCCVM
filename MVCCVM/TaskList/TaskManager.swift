//
//  TaskManager.swift
//  MVCCVM
//
//  Created by Kacper Woźniak on 17/12/2017.
//

final class TaskManager {

    static let instance = TaskManager()
    private init() {}
    var tasks = [
        Task(name: "Model", description: "• content\n• raw data"),
        Task(name: "View", description: "• dumb af\n• just a container for a content"),
        Task(name: "(View) Controller", description: "• ViewModel <-> View binding\n• styling"),
        Task(name: "(Flow) Coordinator", description: "• navigation/routing/presentation"),
        Task(name: "View Model", description: "• business logic")
    ]
    var update: (() -> Void)?

}
