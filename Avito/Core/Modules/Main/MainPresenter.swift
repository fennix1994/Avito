//
//  MainPresenter.swift
//  Avito
//
//  Created by Кирилл Сурков on 27.10.2022.
//

import Foundation

protocol PresenterProtocol: AnyObject {
    var data: [Employee]? { get set }
    var onDidCellSelected: ((Employee) -> Void)? { get set }
    func provideData()
    func onShowDetails(with data: Employee)
}

final class MainPresenter: PresenterProtocol {
    
    enum Constant {
        static let key = "DATA"
    }
    enum CustomError: Error {
        case cache
    }

    // MARK: - Properties
    
    weak var view: MainViewProtocol!
    var data: [Employee]? {
        didSet {
            data?.sort { $0.name < $1.name }
        }
    }
    var onDidCellSelected: ((Employee) -> Void)?
    private let networkService: NetworkServiceProtocol!
    private let cache = Cache<String, CompanyData>()
    
    // MARK: - Init
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    // MARK: - Methods

    func provideData() {
        if cache.isExpired(forKey: Constant.key) {
            networkService.fetchData { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let companyData):
                        self.data = companyData.company.employees
                        self.view?.success()
                        self.cache.insert(companyData, forKey: Constant.key)
                    case .failure(let error):
                        self.view?.failure(error: error)
                    }
                }
            }
        } else {
            guard let cache = cache.value(forKey: Constant.key) else {
                self.view?.failure(error: CustomError.cache)
                return
            }
            data = cache.company.employees
            view?.success()
        }
    }
    
    func onShowDetails(with data: Employee) {
        onDidCellSelected?(data)
    }
}
