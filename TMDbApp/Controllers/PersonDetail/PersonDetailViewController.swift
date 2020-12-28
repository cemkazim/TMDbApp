//
//  ActorDetailViewController.swift
//  TMDbApp
//
//  Created by Cem Kazım on 27.12.2020.
//

import UIKit
import SDWebImage

class PersonDetailViewController: UIViewController {
    
    // MARK: - UI Objects -
    
    lazy var personImageView: BaseImageViewComponent = {
        let imageView = BaseImageViewComponent(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        return imageView
    }()
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [personNameLabel, personCharacterLabel, personKnownForDepartmentLabel, personGenderLabel, personPopularityLabel])
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    lazy var personNameLabel: BaseLabelComponent = {
        let baseLabelComponent = BaseLabelComponent()
        baseLabelComponent.textAlignment = .center
        baseLabelComponent.font = UIFont.systemFont(ofSize: 24)
        return baseLabelComponent
    }()
    lazy var personCharacterLabel: BaseLabelComponent = {
        let baseLabelComponent = BaseLabelComponent()
        baseLabelComponent.textAlignment = .center
        baseLabelComponent.font = UIFont.systemFont(ofSize: 20)
        return baseLabelComponent
    }()
    lazy var personKnownForDepartmentLabel: BaseLabelComponent = {
        let baseLabelComponent = BaseLabelComponent()
        baseLabelComponent.font = UIFont.systemFont(ofSize: 20)
        baseLabelComponent.textAlignment = .center
        return baseLabelComponent
    }()
    lazy var personGenderLabel: BaseLabelComponent = {
        let baseLabelComponent = BaseLabelComponent()
        baseLabelComponent.font = UIFont.systemFont(ofSize: 20)
        baseLabelComponent.textAlignment = .center
        return baseLabelComponent
    }()
    lazy var personPopularityLabel: BaseLabelComponent = {
        let baseLabelComponent = BaseLabelComponent()
        baseLabelComponent.font = UIFont.systemFont(ofSize: 20)
        baseLabelComponent.textAlignment = .center
        return baseLabelComponent
    }()
    
    // MARK: - Properties -
    
    var personDetailModel: PersonDetailModel?
    
    // MARK: - Lifecycles -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    // MARK: - Methods -
    
    func setupView() {
        navigationItem.title = ConstantValue.personDetailText
        updateBackgroundColor(view, ConstantValue.firstChangableColor, ConstantValue.secondChangableColor)
        view.addSubview(personImageView)
        view.addSubview(labelStackView)
        getData()
    }
    
    func setupConstraints() {
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                personImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
                personImageView.widthAnchor.constraint(equalToConstant: 200),
                personImageView.heightAnchor.constraint(equalToConstant: 200),
                personImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                
                personNameLabel.widthAnchor.constraint(equalToConstant: 300),
                
                labelStackView.topAnchor.constraint(equalTo: personImageView.bottomAnchor, constant: 20),
                labelStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                personImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
                personImageView.widthAnchor.constraint(equalToConstant: 200),
                personImageView.heightAnchor.constraint(equalToConstant: 200),
                personImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                personNameLabel.widthAnchor.constraint(equalToConstant: 300),
                
                labelStackView.topAnchor.constraint(equalTo: personImageView.bottomAnchor, constant: 20),
                labelStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        }
    }
    
    func getData() {
        personImageView.sd_setImage(with: personDetailModel?.personProfilePath, completed: nil)
        if let personName = personDetailModel?.personName,
           let personCharacter = personDetailModel?.personCharacter,
           let personKnownForDepartment = personDetailModel?.personKnownForDepartment,
           let personGender = personDetailModel?.personGender,
           let personPopularity = personDetailModel?.personPopularity {
            personNameLabel.text = ConstantValue.nameText + personName
            personCharacterLabel.text = ConstantValue.characterText + personCharacter
            personKnownForDepartmentLabel.text = ConstantValue.knownForDepartmentText + personKnownForDepartment
            if personGender == 1 {
                personGenderLabel.text = ConstantValue.genderText + ConstantValue.womanText
            } else {
                personGenderLabel.text = ConstantValue.genderText + ConstantValue.manText
            }
            personPopularityLabel.text = ConstantValue.popularityText + "\(personPopularity)"
        }
    }
}