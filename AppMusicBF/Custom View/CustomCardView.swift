//
//  CustomCardView.swift
//  AppMusicBF
//
//  Created by Enrico Sousa Gollner on 21/01/24.
//

import UIKit

enum ViewMode  {
    case full, card
}

class CustomCardView: UIView {
    //MARK: - PROPERTIES
    var containerLeadingConstraint: NSLayoutConstraint?
    var containerTopConstraint: NSLayoutConstraint?
    var containerTrailingConstraint: NSLayoutConstraint?
    var containerBottomConstraint: NSLayoutConstraint?
    var dataModel: CardViewModel?
    
    //MARK: - ELEMENTS
    lazy var cardContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 30
        view.layer.opacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: -2)
        view.layer.shadowRadius = 20
        
        return view
    }()
    
    lazy var cardImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .black
        
        return image
    }()
    
    lazy var overlayView: UIView = {
        let overlayView = UIView()
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.backgroundColor = .black.withAlphaComponent(0.6)
        
        return overlayView
    }()
    
    //Perfil image border
    lazy var profileBorderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 25
        
        return view
    }()
    
    lazy var cardProfilePicture: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .black
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        
        return imageView
    }()
    
    lazy var addProfileImageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setBackgroundImage(UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    //Music category
    lazy var cardCategoryTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    //Category Date
    lazy var cardCategoryDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textColor = .white
        
        return label
    }()
    
    //Category title
    lazy var cardTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 31, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var likeAndTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0 // Auto-ajust
        
        return label
    }()
    
    lazy var actionsView: CardActionView = {
        let cardActionView = CardActionView()
        cardActionView.translatesAutoresizingMaskIntoConstraints = false
        
        return cardActionView
    }()
    
    //MARK: - init (Constructor method)
    init(mode: ViewMode) {
        let frame = CGRect.zero
        super.init(frame: frame)
        self.setVisualElements()
        self.updateLayoutConstraints(for: mode)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setVisualElements() {
        self.addSubview(self.cardContainerView)
        
        self.cardContainerView.addSubview(self.cardImage)
        self.cardContainerView.addSubview(self.overlayView)
        
        self.cardContainerView.addSubview(self.cardProfilePicture)
        self.cardContainerView.addSubview(self.profileBorderView)
        self.cardContainerView.addSubview(self.addProfileImageButton)
        self.cardContainerView.addSubview(self.cardCategoryTitleLabel)
        self.cardContainerView.addSubview(self.cardCategoryDateLabel)
        
        self.cardContainerView.addSubview(self.cardTitle)
        self.cardContainerView.addSubview(self.likeAndTimeLabel)
        self.cardContainerView.addSubview(self.descriptionTitleLabel)
        self.cardContainerView.addSubview(self.actionsView)
        
        self.setUpConstraints()
    }
    
    private func setUpConstraints() {
        self.containerLeadingConstraint = cardContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30)
        self.containerLeadingConstraint?.isActive = true // When we're not using NSLayoutConstraint.activate, we need to set 'isActivate' as true to constraints work
        
        self.containerTopConstraint = cardContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15)
        self.containerTopConstraint?.isActive = true
        
        self.containerTrailingConstraint = cardContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)
        self.containerTrailingConstraint?.isActive = true
        
        self.containerBottomConstraint = cardContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15)
        self.containerBottomConstraint?.isActive = true
        
        self.cardImage.pin(to: self.cardContainerView)
        self.overlayView.pin(to: self.cardContainerView)
        
        NSLayoutConstraint.activate([
            self.profileBorderView.topAnchor.constraint(equalTo: self.cardContainerView.topAnchor, constant: 60),
            self.profileBorderView.centerXAnchor.constraint(equalTo: self.cardContainerView.centerXAnchor),
            self.profileBorderView.widthAnchor.constraint(equalToConstant: 50),
            self.profileBorderView.heightAnchor.constraint(equalToConstant: 50),
            
            self.cardProfilePicture.centerXAnchor.constraint(equalTo: self.profileBorderView.centerXAnchor),
            self.cardProfilePicture.centerYAnchor.constraint(equalTo: self.profileBorderView.centerYAnchor),
            self.cardProfilePicture.widthAnchor.constraint(equalToConstant: 40),
            self.cardProfilePicture.heightAnchor.constraint(equalToConstant: 40),
            
            self.addProfileImageButton.trailingAnchor.constraint(equalTo: self.profileBorderView.trailingAnchor, constant: 4),
            self.addProfileImageButton.bottomAnchor.constraint(equalTo: self.profileBorderView.bottomAnchor, constant: 4),
            self.addProfileImageButton.widthAnchor.constraint(equalToConstant: 15),
            self.addProfileImageButton.heightAnchor.constraint(equalToConstant: 15),
            
            self.cardCategoryTitleLabel.topAnchor.constraint(equalTo: self.profileBorderView.bottomAnchor, constant: 10),
            self.cardCategoryTitleLabel.centerXAnchor.constraint(equalTo: self.cardContainerView.centerXAnchor),
            
            self.cardCategoryDateLabel.topAnchor.constraint(equalTo: self.cardCategoryTitleLabel.bottomAnchor, constant: 2),
            self.cardCategoryDateLabel.centerXAnchor.constraint(equalTo: self.cardContainerView.centerXAnchor),
            
            self.cardTitle.topAnchor.constraint(equalTo: self.cardCategoryTitleLabel.bottomAnchor, constant: 20),
            self.cardTitle.leadingAnchor.constraint(equalTo: self.cardContainerView.leadingAnchor, constant: 20),
            self.cardTitle.trailingAnchor.constraint(equalTo: self.cardContainerView.trailingAnchor, constant: -20),
            
            self.likeAndTimeLabel.topAnchor.constraint(equalTo: self.cardTitle.bottomAnchor, constant: 30),
            self.likeAndTimeLabel.centerXAnchor.constraint(equalTo: self.cardContainerView.centerXAnchor),
            
            self.descriptionTitleLabel.topAnchor.constraint(equalTo: self.likeAndTimeLabel.bottomAnchor, constant: 30),
            self.descriptionTitleLabel.leadingAnchor.constraint(equalTo: self.cardContainerView.leadingAnchor, constant: 40),
            self.descriptionTitleLabel.trailingAnchor.constraint(equalTo: self.cardContainerView.trailingAnchor, constant: -40),
            
            self.actionsView.bottomAnchor.constraint(equalTo: self.cardContainerView.bottomAnchor, constant: -20),
            self.actionsView.leadingAnchor.constraint(equalTo: self.cardContainerView.leadingAnchor, constant: 20),
            self.actionsView.trailingAnchor.constraint(equalTo: self.cardContainerView.trailingAnchor, constant: -20),
            self.actionsView.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    private func updateLayoutConstraints(for mode: ViewMode) {
        if mode == .full {
            self.configContainerConstraints(leadingAnchor: 0, topAnchor: 0, trailingAnchor: 0, bottomAnchor: 0)
            self.descriptionTitleLabel.isHidden = false
        } else {
            self.configContainerConstraints(leadingAnchor: 30, topAnchor: 15, trailingAnchor: -30, bottomAnchor: -15)
            self.descriptionTitleLabel.isHidden = true
        }
        
        self.actionsView.updateLayout(for: mode)
    }
    
    private func configContainerConstraints(leadingAnchor: CGFloat, topAnchor: CGFloat, trailingAnchor: CGFloat, bottomAnchor: CGFloat) {
        self.containerLeadingConstraint?.constant = leadingAnchor
        self.containerTopConstraint?.constant = topAnchor
        self.containerTrailingConstraint?.constant = trailingAnchor
        self.containerBottomConstraint?.constant = bottomAnchor
    }
    
    public func setUpViewData(data: CardViewModel) {
        self.cardCategoryTitleLabel.text = data.categoryName
        self.cardCategoryDateLabel.text = data.categoryDate
        self.cardTitle.text = data.cardTitle
        self.likeAndTimeLabel.attributedText = NSAttributedString.featureText(data.likeCount ?? "", data.duration ?? "")
        self.descriptionTitleLabel.text = data.cardDescription
        self.cardImage.image = UIImage(named: data.cardImage ?? "")
        self.cardProfilePicture.image = UIImage(named: data.categoryImage ?? "")
    }
}
