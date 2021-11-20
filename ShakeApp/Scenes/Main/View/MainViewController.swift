//
//  MainViewController.swift
//  ShakeApp
//
//  Created by Softermii-User on 20.10.2021.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Properties
    private let answerLabel = UILabel()
    private let questionTextField = UITextField()

    private var viewModel: MainViewModel

    // MARK: - Init
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        questionTextField.resignFirstResponder()
    }

    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {

    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard let text = questionTextField.text, !text.isEmpty else { return }

        viewModel.loadData(for: text)
    }

    // MARK: - Private
    private func setupViews() {
        view.backgroundColor = Asset.Colors.whiteColor.color

        self.navigationController?.navigationBar.topItem?.title = L10n.AppName.text
        self.navigationController?.navigationBar.tintColor = Asset.Colors.grayColor.color
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(rigthButtonClicked))

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)

        view.addSubview(answerLabel)
        view.addSubview(questionTextField)

        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        questionTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            answerLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            answerLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),

            questionTextField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -80),
            questionTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            questionTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            questionTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ])

        answerLabel.text = L10n.Answer.empty
        answerLabel.textColor = Asset.Colors.blackColor.color

        questionTextField.borderStyle = .roundedRect
        questionTextField.textAlignment = .center
        questionTextField.backgroundColor = Asset.Colors.grayColor.color
        questionTextField.placeholder = L10n.Question.Placeholder.text
        
        viewModel.shouldHandlerFetchData = { [weak self] text in
            self?.answerLabel.text = text
        }
    }

    @objc private func rigthButtonClicked() {
        let settingsVC = SettingsViewController(storageDataProvider: StorageService())
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }

    @objc private func dismissKeyboard() {
        questionTextField.resignFirstResponder()
    }

}
