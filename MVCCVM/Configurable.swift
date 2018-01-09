//
//  Configurable.swift
//  MVCCVM
//
//  Created by Kacper Woźniak on 08/10/2017.
//

protocol Configurable {

    associatedtype ViewModel
    func configure(using viewModel: ViewModel)

}
