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

    private var networkDataProvider: NetworkDataProvider
    private let storageDataProvider: StorageDataProvider

    // MARK: - Init
    init(networkDataProvider: NetworkDataProvider, storageDataProvider: StorageDataProvider) {
        self.networkDataProvider = networkDataProvider
        self.storageDataProvider = storageDataProvider
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
        networkDataProvider.delegate = self

    }

    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        networkDataProvider.delegate = nil
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard let text = questionTextField.text, !text.isEmpty else { return }
        networkDataProvider.fetchData(for: text)
    }

    // MARK: - Private
    private func setupViews() {
        view.backgroundColor = Asset.Colors.whiteColor.color

        self.navigationController?.navigationBar.topItem?.title = L10n.appName
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(rigthButtonClicked))

        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
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

        answerLabel.text = L10n.greeting
        answerLabel.textColor = Asset.Colors.blackColor.color
        
        questionTextField.borderStyle = .roundedRect
        questionTextField.textAlignment = .center
        questionTextField.backgroundColor = Asset.Colors.greyColor.color
        questionTextField.placeholder = L10n.questionTextPlaceHolder
    }

    @objc private func rigthButtonClicked() {
        let settingsVC = SettingsViewController(storageDataProvider: StorageService())
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }

    @objc private func dissmissKeyboard() {
        questionTextField.resignFirstResponder()
    }

}

// MARK: - NetworkServiceDelegate
extension MainViewController: NetworkServiceDelegate {
    func didGetError() {
        let customAnswer = storageDataProvider.readData(for: L10n.customAnswerKey)
        guard let answer = customAnswer, !answer.isEmpty else {
            answerLabel.text = L10n.defaultAnswer
            return
        }
        answerLabel.text = answer
    }

    func didFetchMagic(_ magicData: MagicData) {
        answerLabel.text = magicData.answer
    }
}
