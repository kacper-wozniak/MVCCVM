//
//  TaskCell.swift
//  MVCCVM
//
//  Created by Kacper Woźniak on 08/10/2017.
//

import UIKit

protocol TaskCellModelProtocol {

    var title: String { get }

}

final class TaskCell: UITableViewCell, ReusableCell, Configurable {

    @IBOutlet weak var titleLabel: UILabel! {
        didSet { titleLabel.textColor = .purple }
    }

    func configure(using cellModel: TaskCellModelProtocol) {
        titleLabel.text = cellModel.title
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        titleLabel.textColor = highlighted ? .white : .purple
        backgroundColor = highlighted ? .purple : .white
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        titleLabel.textColor = selected ? .white : .purple
        backgroundColor = selected ? .purple : .white
    }

}
