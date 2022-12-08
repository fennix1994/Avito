//
//  MainViewController.swift
//  Avito
//
//  Created by Кирилл Сурков on 27.10.2022.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

class MainViewController: UIViewController {
    enum CellIdentifier {
        static let company = "cell"
    }
   
    // MARK: - Properties
    
    var presenter: PresenterProtocol!
    private let tableView = UITableView() 
    private let refreshControl = UIRefreshControl()
    
    // MARK: - LiveCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter.provideData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - Private methods
    
    private func setup() {
        view.addSubview(tableView)
        tableView.register(
            MainViewControllerCell.self,
            forCellReuseIdentifier: CellIdentifier.company
        )
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70
        tableView.pin(to: view)
        tableView.refreshControl = refreshControl
        navigationItem.title = "Employees"
        navigationController?.navigationBar.prefersLargeTitles = true
        refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
    }
    
    @objc
    private func onRefresh() {
        presenter.provideData()
    }
}

// MARK: - UITableView extensions

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CellIdentifier.company, for: indexPath) as? MainViewControllerCell,
        let company = presenter.data?[indexPath.row] else { return UITableViewCell() }
        cell.set(company: company)
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let data = presenter.data?[indexPath.row] else { return }
        presenter.onShowDetails(with: data)
    }
}

// MARK: - MainViewProtocol

extension MainViewController: MainViewProtocol {
    
    func success() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func failure(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .destructive)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
