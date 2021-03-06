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
    
    var personDetailViewModel: PersonDetailViewModel?
    
    // MARK: - Lifecycles -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    // MARK: - Methods -
    
    func setupView() {
        navigationItem.title = ConstantTexts.personDetailText
        updateBackgroundColor(view, CustomColors.firstChangableColor, CustomColors.secondChangableColor)
        view.addSubview(personImageView)
        view.addSubview(labelStackView)
        getDataFrom(personDetailViewModel?.personDetailModel)
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
    
    func getDataFrom(_ movieCastModel: PersonDetailModel?) {
        if movieCastModel?.profilePath != nil {
            let imageUrl = URL(string: APIParam.movieImageUrl.rawValue + (movieCastModel?.profilePath ?? ""))
            personImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            personImageView.sd_setImage(with: imageUrl, completed: nil)
        } else {
            personImageView.image = UIImage(named: ImageNames.placeholderProfile)
        }
        personNameLabel.text = ConstantTexts.nameText + (movieCastModel?.name ?? ConstantTexts.unknownText)
        personKnownForDepartmentLabel.text = ConstantTexts.knownForDepartmentText + (movieCastModel?.knownForDepartment ?? ConstantTexts.unknownText)
        personCharacterLabel.text = ConstantTexts.characterText + (movieCastModel?.character ?? ConstantTexts.unknownText)
        personPopularityLabel.text = "\(ConstantTexts.popularityText)\(movieCastModel?.popularity ?? 0.0)"
        if let personGender = movieCastModel?.gender {
            switch personGender {
            case 1:
                personGenderLabel.text = ConstantTexts.genderText + ConstantTexts.womanText
            case 2:
                personGenderLabel.text = ConstantTexts.genderText + ConstantTexts.manText
            default:
                personGenderLabel.text = ConstantTexts.genderText + ConstantTexts.unknownText
            }
        }
    }
}
