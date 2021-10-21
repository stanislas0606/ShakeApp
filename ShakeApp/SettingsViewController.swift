//
//  SettingsViewController.swift
//  ShakeApp
//
//  Created by Softermii-User on 20.10.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //MARK: Properties
    
    private let customAnswerTextField = UITextField()
    private let saveButton = UIButton()

    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //MARK: Private
    
    private func setupViews() {
        view.backgroundColor = .white
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        view.addGestureRecognizer(tap)
        
        view.addSubview(saveButton)
        view.addSubview(customAnswerTextField)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        customAnswerTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            saveButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 120),
            
            customAnswerTextField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -80),
            customAnswerTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            customAnswerTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            customAnswerTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ])
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.layer.cornerRadius = 5
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = UIColor.black.cgColor
        saveButton.layer.masksToBounds = true
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        customAnswerTextField.borderStyle = .roundedRect
        customAnswerTextField.textAlignment = .center
        customAnswerTextField.backgroundColor = .systemGray2
        customAnswerTextField.placeholder = "Enter your custom answer"
    }
    
    @objc private func dissmissKeyboard() {
        customAnswerTextField.resignFirstResponder()
    }

    @objc private func saveButtonTapped() {
        UserDefaults.standard.setValue(customAnswerTextField.text, forKey:  "customAnswer")
        customAnswerTextField.text = nil
    }
}
