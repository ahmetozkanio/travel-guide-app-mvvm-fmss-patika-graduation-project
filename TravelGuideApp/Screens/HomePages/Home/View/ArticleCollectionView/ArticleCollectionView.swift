//
//  ArticleCollectionView.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 3.10.2022.
//

import UIKit


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

extension HomeViewController: HomeViewModelProtocol{
    func articleItemsReload() {
        DispatchQueue.main.async {
              self.articleCollectionView.reloadData()
          }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return homeViewModel.getArticleItemCount()
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCollectionViewCell", for: indexPath) as? ArticleCollectionViewCell
        
        if let cellData = homeViewModel.getArticleCellData(indexPath: indexPath) {
            cell?.configureArticleCellData(item: cellData)
            return cell!
        }
            return cell!
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        goToDetailViewController( homeViewModel.didClickItem(at: indexPath.row) )
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.8   , height: collectionView.frame.height * 1 )
    }
}
