//
//  DetailTableViewCellScreen.swift
//  AppMusicBF
//
//  Created by Enrico Sousa Gollner on 03/02/24.
//

import UIKit

class DetailTableViewCellScreen: UIView {
    
    lazy var thumbImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "demo")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        
        return imageView
    }()
    
    lazy var title: UILabel = {
        let titleLabel: UILabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Text here"
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        titleLabel.textColor = .black
        
        return titleLabel
    }()
    
    lazy var subtitle: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.text = "Text here"
        subtitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        subtitleLabel.textColor = .lightGray
        
        return subtitleLabel
    }()
    
    lazy var likeButton: UIButton = {
        let likeButton = UIButton()
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.setBackgroundImage(UIImage(named: "love")?.withRenderingMode(.alwaysTemplate), for: .normal)
        likeButton.tintColor = .lightGray
        
        return likeButton
    }()
    
    lazy var moreButton: UIButton = {
        let moreButton = UIButton()
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        moreButton.setBackgroundImage(UIImage(named: "more")?.withRenderingMode(.alwaysOriginal), for: .normal)
        moreButton.tintColor = .lightGray
        
        return moreButton
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setVisualElements() {
        self.addSubview(self.thumbImage)
        self.addSubview(self.title)
        self.addSubview(self.subtitle)
        self.addSubview(self.likeButton)
        self.addSubview(self.moreButton)
        
        self.setUpConstraints()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            self.thumbImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.thumbImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.thumbImage.heightAnchor.constraint(equalToConstant: 60),
            self.thumbImage.widthAnchor.constraint(equalToConstant: 60),
            
            self.title.leadingAnchor.constraint(equalTo: self.thumbImage.trailingAnchor, constant: 15),
            self.title.topAnchor.constraint(equalTo: self.topAnchor, constant: 17),
            
            self.subtitle.leadingAnchor.constraint(equalTo: self.thumbImage.trailingAnchor, constant: 15),
            self.subtitle.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 4),
            
            self.moreButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            self.moreButton.heightAnchor.constraint(equalToConstant: 35),
            self.moreButton.widthAnchor.constraint(equalToConstant: 35),
            self.moreButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            self.likeButton.trailingAnchor.constraint(equalTo: self.moreButton.leadingAnchor, constant: -15),
            self.likeButton.heightAnchor.constraint(equalToConstant: 35),
            self.likeButton.widthAnchor.constraint(equalToConstant: 35),
            self.likeButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    public func setUpCell(data: CardListModel) {
        self.title.text = data.listTitle
        self.subtitle.text = data.listSubtitle
        self.thumbImage.image = UIImage(named: data.listImage ?? "")
    }
    
}
