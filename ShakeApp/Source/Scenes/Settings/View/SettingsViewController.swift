//
//  SettingsViewController.swift
//  ShakeApp
//
//  Created by Softermii-User on 20.10.2021.
//

import UIKit
import SnapKit

final class SettingsViewController: UIViewController {

    // MARK: Properties
    private let customAnswerTextField = UITextField()
    private let saveButton = UIButton()
    
    private let horizontalPadding = 20
    private let verticalPadding = 24

    private let viewModel: SettingsViewModel

    // MARK: - Init
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSaveButtonConstraints()
        setupCustomAnswerTextFieldConstraints()
        setupViews()
    }

    // MARK: Private
    @objc private func dismissKeyboard() {
        customAnswerTextField.resignFirstResponder()
    }

    @objc private func saveButtonTapped() {
        viewModel.saveButtonHandler?(customAnswerTextField.text ?? "")
        customAnswerTextField.text = nil
    }
}

// MARK: - UI Configure
private extension SettingsViewController {
    
    func setupSaveButtonConstraints() {
        view.addSubview(saveButton)
        
        saveButton.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.snp.centerY)
            $0.height.equalTo(35)
            $0.width.equalTo(120)
        })
    }
    
    func setupCustomAnswerTextFieldConstraints() {
        view.addSubview(customAnswerTextField)
        
        customAnswerTextField.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview().inset(horizontalPadding)
            $0.centerXWithinMargins.equalToSuperview()
            $0.bottom.equalTo(self.view.snp.centerY).offset(-verticalPadding)
            $0.height.equalTo(35)
        })
    }
    
    func setupViews() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        view.backgroundColor = Asset.Colors.whiteColor.color

        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.layer.cornerRadius = 5
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = Asset.Colors.blackColor.color.cgColor
        saveButton.layer.masksToBounds = true
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)

        customAnswerTextField.borderStyle = .roundedRect
        customAnswerTextField.textAlignment = .center
        customAnswerTextField.backgroundColor = Asset.Colors.grayColor.color
        customAnswerTextField.placeholder = L10n.Answer.Placeholder.text
    }
}
