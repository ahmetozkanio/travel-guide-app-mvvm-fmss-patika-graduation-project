//
//  HomeViewController.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 27.09.2022.
//

import Foundation
import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet weak var topBgImageView: UIImageView!
    @IBOutlet weak var articleCollectionView: UICollectionView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        uiElementDesignInitial()
        articleCollectionViewInitial()
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
       
      //  performSegue(withIdentifier: "listView", sender: nil)//rooting islemi
       let storyboard = UIStoryboard(name: "ListView", bundle: nil)
       let controller  = storyboard.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .flipHorizontal
        self.present(controller, animated: true, completion: nil)
      // self.navigationController?.pushViewController(controller, animated: true)
    }
}


extension HomeViewController{
    func articleCollectionViewInitial(){
        articleCollectionView.delegate = self
        articleCollectionView.dataSource = self
        articleRegisterCell()
    }
    func articleRegisterCell(){
        
        articleCollectionView.register(.init(nibName: "ArticleCollectionViewCell",bundle:nil),forCellWithReuseIdentifier: "ArticleCollectionViewCell")
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCollectionViewCell", for: indexPath) as? ArticleCollectionViewCell
        
              
              return cell!
    }
    
    
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.8   , height: collectionView.frame.height * 1 )
        
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
       // topBgImageView.layer.shadowRadius = 10.0
        topBgImageView.layer.masksToBounds = false
        topBgImageView.layer.cornerRadius = 25.0
      
    }
}
