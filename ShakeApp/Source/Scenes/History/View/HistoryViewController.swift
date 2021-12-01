//
//  HistoryViewController.swift
//  ShakeApp
//
//  Created by Softermii-User on 01.12.2021.
//

import UIKit
import SnapKit

final class HistoryViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: HistoryViewModel
    private let dbDataProvider = RealmService()
    
    private let tableView = UITableView()
    
    // MARK: - Init
    init(viewModel: HistoryViewModel) {
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
        setupTableViewConstraints()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.updateHistory()
        tableView.reloadData()
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countOfHistory()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: UITableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.selectionStyle = .none
        
        DispatchQueue.main.async { [self] in
            let historyItem = viewModel.history(at: indexPath.row)
            cell.textLabel?.text = historyItem.historyText
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension

    }
    
    // MARK: - UI Configure
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = L10n.Title.history
    }
    
    private func setupTableViewConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupViews() {
        let identifier = String(describing: UITableViewCell.self)
        
        tableView.backgroundColor = Asset.Colors.whiteColor.color
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableView.automaticDimension

    }
}
