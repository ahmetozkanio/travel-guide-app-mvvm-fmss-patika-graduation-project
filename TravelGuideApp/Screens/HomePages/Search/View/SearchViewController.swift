//
//  SearchViewController.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 27.09.2022.
//

import UIKit

class SearchViewController: UIViewController {

 
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchUI()
    }
    

    

}

private extension SearchViewController{
    private func searchUI(){
        searchTextField.rightViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        let image = UIImage(named: "search")
        imageView.image = image
        searchTextField.rightView = imageView
    }
}
