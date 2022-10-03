//
//  HomeViewController.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 27.09.2022.
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet weak var topBgImageView: UIImageView!
    @IBOutlet weak var articleCollectionView: UICollectionView!
    
    lazy var homeViewModel: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiElementDesignInitial()
        articleCollectionViewInitial()
        
        homeViewModel.delegate = self
        homeViewModel.didViewLoad()
        
    }
    // MARK: - BUTTON CLICK
    @IBAction func flightButtonClicked(_ sender: Any) {
        goToListViewController()
    }
    @IBAction func hotelButtonClicked(_ sender: Any) {
        goToListViewController()
    }
}

extension HomeViewController{
    private func goToListViewController(){
        let storyboard = UIStoryboard(name: "ListView", bundle: nil)
        let controller  = storyboard.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .flipHorizontal
        self.present(controller, animated: true, completion: nil)
    }
    func goToDetailViewController(_ item: ArticleElement?){
        
        let storyboard = UIStoryboard(name: "DetailView", bundle: nil)
        let controller  = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .flipHorizontal
        controller.item = item
        self.present(controller, animated: true, completion: nil)
        
    }
}
private extension HomeViewController{
    private func uiElementDesignInitial(){
        imageShadow()
    }
    private func imageShadow(){
        topBgImageView.layer.shadowColor = UIColor(red: 240.0 / 255.0, green: 240.0 / 255.0, blue: 240.0 / 255.0, alpha: 1.0).cgColor
        topBgImageView.layer.shadowOffset = CGSize(width: 0, height: 16)
        topBgImageView.layer.shadowOpacity = 1.0
        //topBgImageView.layer.shadowRadius = 10.0
        topBgImageView.layer.masksToBounds = false
        topBgImageView.layer.cornerRadius = 25.0
    }
}



