//
//  DetailView + Extension.swift
//  AppMusicBF
//
//  Created by Enrico Sousa Gollner on 05/02/24.
//

import Foundation

extension DetailViewController {
    public func getSafeAreasTopPadding() -> CGFloat? {
        let window = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows.filter({$0.isKeyWindow}).first
        
        return window?.safeAreaInsets.top
    }
}

extension DetailViewControllerScreen {
    
}
