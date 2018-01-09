//
//  TaskViewModelProtocol.swift
//  MVCCVM
//
//  Created by Kacper Woźniak on 09/01/2018.
//

enum TaskViewModelAction {

    case close

}

enum TaskViewModelChange {

    case navigationBar(NavigationBarModel)
    case editMode(Bool)
    case name(String)
    case description(String)

}

protocol TaskViewModelProtocol {

    var name: String { get set }
    var description: String { get set }

    var navigationBarModel: NavigationBarModel { get }
    var changed: ((TaskViewModelChange) -> ())? { get set }

    func setup()

}
