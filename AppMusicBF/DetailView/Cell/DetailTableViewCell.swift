//
//  DetailTableViewCell.swift
//  AppMusicBF
//
//  Created by Enrico Sousa Gollner on 03/02/24.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    static public let identifier: String = String(describing: DetailTableViewCell.self)
    
    lazy var screen: DetailTableViewCellScreen = {
        let view = DetailTableViewCellScreen(frame: .zero)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpVisualElements() {
        self.contentView.addSubview(self.screen)
        
        self.screen.pin(to: self.contentView)
    }
    
    public func setUpCell(data: CardListModel) {
        self.screen.setUpCell(data: data)
        self.selectionStyle = .none
    }
}
