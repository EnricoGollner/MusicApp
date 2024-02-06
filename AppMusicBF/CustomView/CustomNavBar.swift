//
//  CustomNavBar.swift
//  AppMusicBF
//
//  Created by Enrico Sousa Gollner on 03/02/24.
//

import UIKit

class CustomNavBar: UIView {
    lazy var categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    //Category Date
    lazy var cardTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var featureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var cardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var overlayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black.withAlphaComponent(0.6)
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setVisualElements() {
        self.addSubview(self.cardImage)
        self.addSubview(self.overlayView)
        self.addSubview(self.categoryTitleLabel)
        self.addSubview(self.cardTitle)
        self.addSubview(self.featureLabel)
        
        self.setUpConstraints()
    }
    
    private func setUpConstraints() {
        self.cardImage.pin(to: self)
        self.overlayView.pin(to: self)
        
        NSLayoutConstraint.activate([
            self.categoryTitleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5),
            self.categoryTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.categoryTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            self.cardTitle.leadingAnchor.constraint(equalTo: self.categoryTitleLabel.leadingAnchor),
            self.cardTitle.trailingAnchor.constraint(equalTo: self.categoryTitleLabel.trailingAnchor),
            self.cardTitle.topAnchor.constraint(equalTo: self.categoryTitleLabel.bottomAnchor, constant: 5),
            
            self.featureLabel.leadingAnchor.constraint(equalTo: self.categoryTitleLabel.leadingAnchor),
            self.featureLabel.trailingAnchor.constraint(equalTo: self.categoryTitleLabel.trailingAnchor),
            self.featureLabel.topAnchor.constraint(equalTo: self.cardTitle.bottomAnchor, constant: 5),
        ])
    }
    
    public func setUpCell(data: CardViewModel) {
        self.cardTitle.text = data.cardTitle
        self.categoryTitleLabel.text = data.categoryName
        self.cardImage.image = UIImage(named: data.cardImage ?? "")
        self.featureLabel.attributedText = .featureText(data.likeCount ?? "", data.duration ?? "")
    }
}
