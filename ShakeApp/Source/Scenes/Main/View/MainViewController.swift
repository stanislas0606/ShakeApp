//
//  MainViewController.swift
//  ShakeApp
//
//  Created by Softermii-User on 20.10.2021.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {

    // MARK: - Properties
    private let answerLabel = UILabel()
    private let questionTextField = UITextField()
        
    private var viewModel: MainViewModel
    
    private let horizontalPadding = 20
    private let verticalPadding = 24

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
        
        setupNavigationBar()
        setupAnswerLabelCostraints()
        setupQuestionTextFieldCostraints()
        setupViews()
    }

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        questionTextField.resignFirstResponder()
        viewModel.shouldHandlerFetchData = { [weak self] answer in
            DispatchQueue.main.async {
             self?.answerLabel.text = answer.answerText
            }
        }
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard let text = questionTextField.text, !text.isEmpty, motion == .motionShake else { return }
        viewModel.motionHandler?(text)
    }

    // MARK: - Private
    @objc private func rigthButtonClicked() {
        let provider = StorageService()
        let model = SettingsModel(storageDataProvider: provider)
        let viewModel = SettingsViewModel(model: model)
        let settingsVC = SettingsViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }

    @objc private func dismissKeyboard() {
        questionTextField.resignFirstResponder()
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
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.snp.centerY).offset(-verticalPadding)
            $0.height.equalTo(35)
        })
    }
    
    func setupViews() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
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

