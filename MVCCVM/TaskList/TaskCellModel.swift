//
//  TaskCellModel.swift
//  MVCCVM
//
//  Created by Kacper Woźniak on 08/10/2017.
//

struct TaskCellModel: TaskCellModelProtocol {

    let title: String

    init(task: Task) {
        title = task.name
    }
    
}
