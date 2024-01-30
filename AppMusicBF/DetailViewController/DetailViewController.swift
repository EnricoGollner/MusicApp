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
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension DetailViewController: DetailViewControllerScreenDelegate {
    func tappedCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
}
