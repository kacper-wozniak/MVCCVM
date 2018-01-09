//
//  TaskViewController.swift
//  MVCCVM
//
//  Created by Kacper Woźniak on 07/10/2017.
//

import UIKit

final class TaskViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel! {
        didSet { nameLabel.textColor = .purple }
    }

    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.layer.borderColor = UIColor.purple.withAlphaComponent(0.5).cgColor
            nameTextField.delegate = self
        }
    }

    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet { descriptionLabel.textColor = .purple }
    }

    @IBOutlet weak var descriptionTextView: UITextView! {
        didSet {
            descriptionTextView.layer.borderColor = UIColor.purple.withAlphaComponent(0.5).cgColor
            descriptionTextView.delegate = self
        }
    }
    
    var viewModel: TaskViewModelProtocol! {
        didSet {
            viewModel.changed = { [weak self] change in
                switch change {
                case .editMode(let enabled): self?.editModel(enabled)
                case .navigationBar(let model): self?.configure(using: model)
                case .name(let text): self?.nameTextField.text = text
                case .description(let text): self?.descriptionTextView.text = text
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        viewModel.setup()
    }

    func editModel(_ enabled: Bool) {
        nameTextField.isEnabled = enabled
        nameTextField.layer.borderWidth = enabled ? 1 : 0
        descriptionTextView.isEditable = enabled
        descriptionTextView.layer.borderWidth = enabled ? 1 : 0
    }
    
}

extension TaskViewController: UITextFieldDelegate, UITextViewDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        viewModel.name = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        return true
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        viewModel.description = (textView.text as NSString).replacingCharacters(in: range, with: text)
        return true
    }

}
