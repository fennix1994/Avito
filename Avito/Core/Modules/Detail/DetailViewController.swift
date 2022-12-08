//
//  DetailViewController.swift
//  Avito
//
//  Created by Кирилл Сурков on 29.10.2022.
//

import UIKit

final class DetailViewController: UIViewController {
    
    // MARK: - Properties

    var presenter: DetailPresenterProtocol!
    let imageView = UIImageView()
    let nameText = UILabel()
    let nameLabel = UILabel()
    let phoneNumberText = UILabel()
    let phoneNumberLabel = UILabel()
    let skillsText = UILabel()
    let skillsLabel = UILabel()
    let companyLabel = UILabel()
    
    // MARK: - LiveCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter.provideData()
        configureElements()
    }
    
    // MARK: - Methods

    func configure(with data: Employee) {
        nameText.text = "Имя: "
        phoneNumberText.text = "Phone number: "
        skillsText.text = "Skills: "
        nameLabel.text = data.name
        phoneNumberLabel.text = data.phoneNumber
        skillsLabel.text = data.skills.joined(separator: ", ")
    }
    
    private func setup() {
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(nameText)
        view.addSubview(nameLabel)
        view.addSubview(phoneNumberText)
        view.addSubview(phoneNumberLabel)
        view.addSubview(skillsText)
        view.addSubview(skillsLabel)
        view.addSubview(companyLabel)
    }
    
    private func configureElements() {
        configureImageView()
        configureText()
        applyUIConstraints()
    }
    
    private func configureImageView() {
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "emptyPhoto")
    }
    
    private func configureText() {
        nameText.font = .boldSystemFont(ofSize: 20)
        phoneNumberText.font = .boldSystemFont(ofSize: 20)
        skillsText.font = .boldSystemFont(ofSize: 20)
    }
    
    // MARK: - Constraints

    private func applyUIConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameText.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberText.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        skillsText.translatesAutoresizingMaskIntoConstraints = false
        skillsLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 130),
            imageView.widthAnchor.constraint(equalToConstant: 130),
            
            nameText.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 100),
            nameText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            
            nameLabel.topAnchor.constraint(equalTo: nameText.bottomAnchor, constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),

            phoneNumberText.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            phoneNumberText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),

            phoneNumberLabel.topAnchor.constraint(equalTo: phoneNumberText.bottomAnchor, constant: 20),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            
            skillsText.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 20),
            skillsText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),

            skillsLabel.topAnchor.constraint(equalTo: skillsText.bottomAnchor, constant: 20),
            skillsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50)
            ])
    }
}
