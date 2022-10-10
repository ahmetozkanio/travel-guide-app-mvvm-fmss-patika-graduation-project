//
//  TabBarViewController.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 27.09.2022.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    private func configure(){
        tabBarTopShadow()
        loadTabs()
    }
}

private extension TabBarViewController{
    
    private func loadTabs(){
        let homeViewStoryboard = UIStoryboard(name: "HomeView", bundle: nil)
        let homeViewController = homeViewStoryboard.instantiateInitialViewController()!
        
        let searchViewStoryboard = UIStoryboard(name: "SearchView", bundle: nil)
        let searchViewController = searchViewStoryboard.instantiateInitialViewController()!
        
        let bookmarksViewStoryboard = UIStoryboard(name: "BookmarksView", bundle: nil)
        let bookmarksViewController = bookmarksViewStoryboard.instantiateInitialViewController()!
        
        self.setViewControllers([homeViewController,searchViewController,bookmarksViewController], animated: true)
    }
    
    private func tabBarTopShadow(){
        let lineView = UIView(frame: CGRect(x: 0, y: -24, width: tabBar.frame.size.width, height: 24))
        let gradient = CAGradientLayer()
        gradient.frame = lineView.bounds
        gradient.colors = [UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor,UIColor(red: 240.0 / 255.0, green: 240.0 / 255.0, blue: 240.0 / 255.0, alpha: 1.0).cgColor]
        lineView.layer.insertSublayer(gradient, at: 0)
        tabBar.addSubview(lineView)
    }
}
