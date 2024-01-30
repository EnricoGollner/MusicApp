//
//  CardViewTableViewCell.swift
//  AppMusicBF
//
//  Created by Enrico Sousa Gollner on 21/01/24.
//

import UIKit

class CardViewTableViewCell: UITableViewCell {
    static let identifier: String = String(describing: CardViewTableViewCell.self)
    
    lazy var cardView: CustomCardView = {
        let view = CustomCardView(mode: .card)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpView()
    }
    
    public func setUpCell(data: CardViewModel) {
        self.selectionStyle = .none
        self.cardView.setUpViewData(data: data)
    }
    
    fileprivate func setUpView() {
        self.contentView.addSubview(self.cardView)
        self.cardView.pin(to: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
