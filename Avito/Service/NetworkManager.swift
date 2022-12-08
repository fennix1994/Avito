//
//  NetworkManager.swift
//  Avito
//
//  Created by Кирилл Сурков on 27.10.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData(completion: @escaping (Result<CompanyData, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    func fetchData(completion: @escaping (Result<CompanyData, Error>) -> Void) {
        guard let url = URL(string: API.v3) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let obj = try JSONDecoder().decode(CompanyData.self, from: data)
                completion(.success(obj))
            } catch {
                debugPrint("Could not translate the data to the requested type")
                completion(.failure(error))
            }
        }.resume()
    }
}
