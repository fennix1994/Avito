//
//  MainPresenter.swift
//  Avito
//
//  Created by Кирилл Сурков on 27.10.2022.
//

import Foundation

protocol DetailPresenterProtocol: AnyObject {
    var data: Employee? { get set }
    func provideData()
}

final class DetailPresenter: DetailPresenterProtocol {
    
    weak var view: DetailViewController!
    var data: Employee?
    
    // MARK: - Public methods
    
    func provideData() {
        guard let data = data else { return }
        view.configure(with: data)
    }
}
