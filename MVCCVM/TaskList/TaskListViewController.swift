//
//  TaskListViewController.swift
//  MVCCVM
//
//  Created by Kacper Woźniak on 07/10/2017.
//

import UIKit

final class TaskListViewController: UITableViewController {

    var viewModel: TaskListViewModel! {
        didSet {
            viewModel.changed = { [weak self] change in
                switch change {
                case .reloadList: self?.tableView.reloadData()
                case .deleteItem(let indexPath): self?.tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure(using: viewModel.navigationBarModel)
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    func setupTableView() {
        tableView.register(cell: TaskCell.self)
        tableView.separatorColor = .purple
        tableView.separatorInset = .zero
        tableView.rowHeight = 100
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: TaskCell.self)
        let cellModel = viewModel.cellModel(at: indexPath)
        cell.configure(using: cellModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.cellTapped(at: indexPath)
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete { viewModel.cellDeleted(at: indexPath) }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}
