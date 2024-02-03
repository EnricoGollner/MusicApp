//
//  DetailViewController.swift
//  AppMusicBF
//
//  Created by Enrico Sousa Gollner on 25/01/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    var screen: DetailViewControllerScreen?
    private var cardModel: CardViewModel?
    
    override func loadView() {
        self.screen = DetailViewControllerScreen(dataView: self.cardModel)
        self.screen?.configAllDelegates(tableViewDelegate: self, tableViewDataSource: self, scrollViewDelegate: self, detailViewScreenDelegate: self)
        self.view = self.screen
    }
    
    override var prefersStatusBarHidden: Bool {  // hiden in status bar
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func setUpCardData(cardData: CardViewModel) {
        self.cardModel = cardData
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cardModel?.cardList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as? DetailTableViewCell
        cell?.setUpCell(data: self.cardModel?.cardList?[indexPath.row] ?? CardListModel())
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension DetailViewController: DetailViewControllerScreenDelegate {
    func tappedCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
}
