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
        loadTabs()
    }
    private func loadTabs(){
           let homeViewStoryboard = UIStoryboard(name: "HomeView", bundle: nil)
           let homeViewController = homeViewStoryboard.instantiateInitialViewController()!
           
           let searchViewStoryboard = UIStoryboard(name: "SearchView", bundle: nil)
           let searchViewController = searchViewStoryboard.instantiateInitialViewController()!
           
           let bookmarksViewStoryboard = UIStoryboard(name: "BookmarksView", bundle: nil)
           let bookmarksViewController = bookmarksViewStoryboard.instantiateInitialViewController()!
       
           self.setViewControllers([homeViewController,searchViewController,bookmarksViewController], animated: true)
       }
}
