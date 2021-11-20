//
//  MainViewController.swift
//  ShakeApp
//
//  Created by Softermii-User on 20.10.2021.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    // MARK: - Properties
    private let answerLabel = UILabel()
    private let questionTextField = UITextField()

    private var networkDataProvider: NetworkDataProvider
    private let storageDataProvider: StorageDataProvider
    
    private let horizontalPadding = 20
    private let verticalPadding = 24

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
        
        setupNavigationBar()
        setupAnswerLabelCostraints()
        setupQuestionTextFieldCostraints()
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
        let customAnswer = storageDataProvider.readData(for: L10n.Answer.Custom.key)
        guard let answer = customAnswer, !answer.isEmpty else {
            answerLabel.text = L10n.Answer.Default.text
            return
        }
        answerLabel.text = answer
    }

    func didFetchMagic(_ magicData: MagicData) {
        answerLabel.text = magicData.answer
    }
}

// MARK: - UI Configure
private extension MainViewController {
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = L10n.AppName.text
        self.navigationController?.navigationBar.tintColor = Asset.Colors.grayColor.color
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(rigthButtonClicked))
    }
    
    func setupAnswerLabelCostraints() {
        view.addSubview(answerLabel)
        
        answerLabel.snp.makeConstraints ({
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.snp.centerY)
            $0.bottom.lessThanOrEqualToSuperview().inset(verticalPadding)
            $0.leading.trailing.equalToSuperview().inset(horizontalPadding)
            
        })
    }
    
    func setupQuestionTextFieldCostraints() {
        view.addSubview(questionTextField)
        
        questionTextField.snp.makeConstraints ({
            $0.leading.trailing.equalToSuperview().inset(horizontalPadding)
            $0.centerXWithinMargins.equalToSuperview()
            $0.bottom.equalTo(self.view.snp.centerY).offset(-verticalPadding)
            $0.height.equalTo(35)
        })
    }
    
    func setupViews() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        view.addGestureRecognizer(tap)
        
        view.backgroundColor = Asset.Colors.whiteColor.color

        answerLabel.numberOfLines = 0
        answerLabel.text = L10n.Answer.empty
        answerLabel.textColor = Asset.Colors.blackColor.color
        answerLabel.backgroundColor = .cyan
        answerLabel.textAlignment = .natural

        questionTextField.borderStyle = .roundedRect
        questionTextField.textAlignment = .natural
        questionTextField.backgroundColor = Asset.Colors.grayColor.color
        questionTextField.placeholder = L10n.Question.Placeholder.text
    }
}
