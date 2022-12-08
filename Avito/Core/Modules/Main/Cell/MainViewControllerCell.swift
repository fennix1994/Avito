//
//  MainViewControllerCell.swift
//  Avito
//
//  Created by Кирилл Сурков on 29.10.2022.
//

import UIKit

final class MainViewControllerCell: UITableViewCell {
    
    // MARK: - Properties
    
    var portraitImage = UIImageView()
    var name = UILabel()
    var phoneNumber = UILabel()
    let stackView = UIStackView()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        configureElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func set(company: Employee) {
        name.text = company.name
        phoneNumber.text = "Phone number: \(company.phoneNumber)"
    }
    
    private func setup() {
        addSubview(portraitImage)
        addSubview(name)
        addSubview(phoneNumber)
        addSubview(stackView)
        accessoryType = .disclosureIndicator
        
    }
    
    private func configureElements() {
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        stackView.spacing = 5.0
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(phoneNumber)
        
        portraitImage.layer.cornerRadius = 5
        portraitImage.clipsToBounds = true
        portraitImage.image = UIImage(named: "emptyPhoto")
        
        name.numberOfLines = 0
        name.adjustsFontSizeToFitWidth = true
        name.font = .boldSystemFont(ofSize: 20)
        
        phoneNumber.numberOfLines = 0
        phoneNumber.adjustsFontSizeToFitWidth = true
        
        setConstraints()
    }

    // MARK: - Constraints
    
    private func setConstraints() {
        portraitImage.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            portraitImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            portraitImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            portraitImage.heightAnchor.constraint(equalToConstant: 50),
            portraitImage.widthAnchor.constraint(equalToConstant: 50),
            
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: portraitImage.trailingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
