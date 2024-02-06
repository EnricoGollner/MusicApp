//
//  DetailViewControllerScreen.swift
//  AppMusicBF
//
//  Created by Enrico Sousa Gollner on 25/01/24.
//

import UIKit

protocol DetailViewControllerScreenDelegate: AnyObject {
    func tappedCloseButton()
}

class DetailViewControllerScreen: UIView {
    
    var cardModel: CardViewModel?
    var navBarTopAnchor: NSLayoutConstraint?
    
    private weak var delegate: DetailViewControllerScreenDelegate?
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.autoresizingMask = .flexibleHeight
        view.bounces = false
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var navBar: CustomNavBar = {
        let navBar = CustomNavBar()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.backgroundColor = .black
        navBar.setUpCell(data: self.cardModel ?? CardViewModel())
        
        return navBar
    }()
    
    lazy var cardView: CustomCardView = {
        let card: CustomCardView = CustomCardView(mode: .full)
        card.translatesAutoresizingMaskIntoConstraints = false
        card.cardContainerView.layer.cornerRadius = 0
        card.setUpViewData(data: self.cardModel ?? CardViewModel())
        return card
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        return tableView
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white.withAlphaComponent(0.3)
        button.layer.cornerRadius = 15
        button.setBackgroundImage(UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(closePressed), for: .touchUpInside)
        
        return button
    }()
    
    lazy var playerView: CustomPlayerView = {
        let playerView = CustomPlayerView()
        playerView.translatesAutoresizingMaskIntoConstraints = false
        
        return playerView
    }()
    
    @objc func closePressed() {
        self.delegate?.tappedCloseButton()
    }
    
    init(dataView: CardViewModel?) {
        super.init(frame: CGRect())
        
        //When working with StackView, we commonly use DispatchQueue.main.async:
        // - Beacause when we're using a StackView, we're forcing the screen, so the layout will fully readapt
        // It's generated when we select the cell and it will force our tableview to grow. Dispatch will help the rendering.
        //As soon as you add heavy tasks to your app like data loading it slows your UI work down or even freezes it. Concurrency lets you perform 2 or more tasks “simultaneously”. The disadvantage of this approach is that thread safety which is not always as easy to control. F.e. when different tasks want to access the same resources like trying to change the same variable on a different threads or accessing the resources already blocked by the different threads.
        DispatchQueue.main.async {
            self.cardModel = dataView
            self.setUpVisualElements()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpVisualElements() {
        self.addSubview(self.scrollView)
        self.addSubview(self.navBar)
        self.scrollView.addSubview(self.cardView)
        self.scrollView.addSubview(self.tableView)
        self.addSubview(self.closeButton)
        self.addSubview(self.playerView)
        
        self.setUpConstraints()
    }
    
    private func setUpConstraints() {
        
        
        self.scrollView.pin(to: self)
        
        NSLayoutConstraint.activate([
            self.closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.closeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.closeButton.widthAnchor.constraint(equalToConstant: 30),
            self.closeButton.heightAnchor.constraint(equalToConstant: 30),
            
            self.cardView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: -(self.getSafeAreasTopPadding() ?? 0)),
            self.cardView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            self.cardView.heightAnchor.constraint(equalToConstant: 500),
            self.cardView.widthAnchor.constraint(equalToConstant: self.frame.size.width),
            
            self.tableView.topAnchor.constraint(equalTo: self.cardView.bottomAnchor),
            self.tableView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            self.tableView.heightAnchor.constraint(equalToConstant: CGFloat((80 * (cardModel?.cardList?.count ?? 0)) + 20)),
            self.tableView.widthAnchor.constraint(equalToConstant: self.frame.size.width),
            self.tableView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            
            self.navBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.navBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.navBar.heightAnchor.constraint(equalToConstant: ((self.getSafeAreasTopPadding() ?? 0) + 80)),  // Distance from the top (safe area) + card's height
            
            self.playerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.playerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.playerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.playerView.heightAnchor.constraint(equalToConstant: 120)
            
        ])
        
        self.navBarTopAnchor = self.navBar.topAnchor.constraint(equalTo: self.topAnchor, constant: -((self.getSafeAreasTopPadding() ?? 0.0) + 60)) // Distance from the top (safe area) + custom nav Bar card's height
        self.navBarTopAnchor?.isActive = true
    }
    
    public func configAllDelegates(tableViewDelegate: UITableViewDelegate, tableViewDataSource: UITableViewDataSource, scrollViewDelegate: UIScrollViewDelegate, detailViewScreenDelegate: DetailViewControllerScreenDelegate) {
        self.tableView.delegate = tableViewDelegate
        self.tableView.dataSource = tableViewDataSource
        self.scrollView.delegate = scrollViewDelegate
        self.delegate = detailViewScreenDelegate
    }
}

