//
//  CompanyModel.swift
//  Avito
//
//  Created by Кирилл Сурков on 27.10.2022.
//

// MARK: - CompanyData

typealias Employee = CompanyData.Employee

struct CompanyData: Decodable {
    let company: Company
    
    // MARK: - Company
    
    struct Company: Decodable {
        let name: String
        let employees: [Employee]
    }
    
    // MARK: - Employee
    
    struct Employee: Decodable {
        let name, phoneNumber: String
        let skills: [String]
        enum CodingKeys: String, CodingKey {
            case name
            case phoneNumber = "phone_number"
            case skills
        }
    }
}

