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
    @IBOutlet weak var searchNoDataView: UIView!
    
    private let buttonSelectedColor = UIColor(red: 255 / 255.0, green: 71 / 255.0, blue: 96 / 255.0, alpha: 1.0)
    private let buttonUnselectedColor =  UIColor(red: 194 / 255.0, green: 197 / 255.0, blue: 214 / 255.0, alpha: 1.0)
    private lazy var searchViewModel: SearchViewModel = SearchViewModel()
    var modelType = Constant.SearchModel.hotels
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchViewModel.delegate = self
        searchTextField.delegate = self
        searchViewModel.initialSearchListModel(modelType)
        listTableViewInitial()
        searchUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(searchListItemsReload), name: Notification.Name("SearchListItemReloadData"), object: nil)
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
    
    private func goToDetailViewController(_ item: DetailEntity?){
        
        let storyboard = UIStoryboard(name: "DetailView", bundle: nil)
        let controller  = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .coverVertical
        controller.item = item
        self.present(controller, animated: true, completion: nil)
        
    }
}
extension SearchViewController: SearchViewModelProtocol{
    
    func searchNoHideData() {
        searchNoDataView.isHidden = false
    }
    func searchShowData() {
        searchNoDataView.isHidden = true
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
//MARK: Searching TectFiel Process
extension SearchViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var searchText  = textField.text!
        
        // limit to 3 characters
        let characterCountLimit = 3
        
        let startingLength = searchText.count // Length of text
        let lengthToAdd = string.count // Length of text add
        let lengthToReplace = range.length // add/delete o text  add = 0, backspace = 1
        let newLength = startingLength + lengthToAdd - lengthToReplace // Total length
        
        // Backspace Controller
        if range.length == 0{
            searchText += string
        }else if range.length == 1{
            searchText.removeLast()
        }
        // Limit controller
        if characterCountLimit <= newLength{
            // 0.5 second wait after searching process
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.searchViewModel.searchFilter(searchText, self.modelType)
                self.searchListItemsReload()
            }
        }else{
            if !searchViewModel.searchListItems.isEmpty {
                searchViewModel.searchListItems.removeAll()
            }
        }
        self.searchListItemsReload()
        return true
    }
}
//MARK: SEARCH UI PROCESS
private extension SearchViewController{
    private func searchUI(){
        searchNoDataView.isHidden = true
        
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
    
}
