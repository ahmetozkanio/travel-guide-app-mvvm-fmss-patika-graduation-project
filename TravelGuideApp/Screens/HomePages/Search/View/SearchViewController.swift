//
//  SearchViewController.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 27.09.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var hotelsButton: UIButton!
    @IBOutlet weak var flightsButton: UIButton!
    @IBOutlet weak var hotelsButtonLine: UIView!
    @IBOutlet weak var flightsButtonLine: UIView!
    
    
    private let buttonSelectedColor = UIColor(red: 255 / 255.0, green: 71 / 255.0, blue: 96 / 255.0, alpha: 1.0)
    private let buttonUnselectedColor =  UIColor(red: 194 / 255.0, green: 197 / 255.0, blue: 214 / 255.0, alpha: 1.0)
    
    private lazy var searchViewModel: SearchViewModel = SearchViewModel()
    
    var modelType = Constant.SearchModel.hotels
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        searchViewModel.initialSearchListModel(modelType)
        listTableViewInitial()
        searchUI()
        
    }
    @IBAction func hotelsButtonClick(_ sender: Any) {
        modelType = Constant.SearchModel.hotels
        searchViewModel.initialSearchListModel(modelType)
        hotelsButtonSelected()

        
    }
    @IBAction func flightsButtonClick(_ sender: Any) {
        modelType = Constant.SearchModel.flights
        searchViewModel.initialSearchListModel(modelType)
        flightsButtonSelected()
        
    }
    private func hotelsButtonSelected(){
        flightsButtonUnselected()
        
        hotelsButton.setTitleColor(buttonSelectedColor, for: .normal)
        hotelsButton.setImage(UIImage(named: "hotelChecked"), for: .normal)
        hotelsButtonLine.isHidden = false
        
    
      
    }
    private func hotelsButtonUnselected(){
        hotelsButton.setTitleColor(buttonUnselectedColor, for: .normal)
        hotelsButton.setImage(UIImage(named: "hotelUnchecked"), for: .normal)
        hotelsButtonLine.isHidden = true
    
    }
    private func flightsButtonSelected(){
        hotelsButtonUnselected()
    
        flightsButton.setTitleColor(buttonSelectedColor, for: .normal)
        flightsButton.setImage(UIImage(named: "planeChecked"), for: .normal)
        flightsButtonLine.isHidden = false
    }
    private func flightsButtonUnselected(){
        flightsButton.setTitleColor(buttonUnselectedColor, for: .normal)
        flightsButton.setImage(UIImage(named: "planeUnchecked"), for: .normal)
        flightsButtonLine.isHidden = true
    }
    
    private func goToDetailViewController(_ item: DetailEntity?){
        
        let storyboard = UIStoryboard(name: "DetailView", bundle: nil)
        let controller  = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .coverVertical
        controller.item = item
        self.present(controller, animated: true, completion: nil)
        
    }
}

private extension SearchViewController{
    @objc func searchListItemsReload() {
        DispatchQueue.main.async {
            self.searchTableView.reloadData()
        }
    }
}


private extension SearchViewController{
    private func listTableViewInitial(){
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableViewRegister()
    }
    private func searchTableViewRegister(){
        searchTableView.register(UINib(nibName: "GlobalTableViewCell", bundle: nil), forCellReuseIdentifier: "GlobalTableViewCell")
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.searchListItems.count > 0 ? searchViewModel.searchListItems.count : 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         goToDetailViewController( searchViewModel.didClickItem(at: indexPath.row, modelType))
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GlobalTableViewCell") as! GlobalTableViewCell
        
        if let cellData = searchViewModel.getSearchListCellData(indexPath: indexPath, initial: modelType) {
            cell.configureCellData(cellData)
            return cell
        }
        return cell
    }
    
    
}



extension SearchViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //input text
        let searchText  = textField.text! + string
        print(searchText)
        if searchText.count >= 2{
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.searchViewModel.searchFilter(searchText, self.modelType)
                self.searchListItemsReload()
            }
         
        }else{
            searchViewModel.searchListItems.removeAll()
        }
      
        searchListItemsReload()
        
        
        return true
    }
}
private extension SearchViewController{
    private func searchUI(){
        searchTextField.rightViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        let image = UIImage(named: "search")
        imageView.image = image
        searchTextField.rightView = imageView
        
        
        hotelFlightButtonUI()
    }
    private func hotelFlightButtonUI(){
        hotelsButtonSelected()
        flightsButtonUnselected()
    }
}
