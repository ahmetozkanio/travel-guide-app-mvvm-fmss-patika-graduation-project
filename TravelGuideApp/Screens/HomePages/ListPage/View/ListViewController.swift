//
//  ListViewController.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 30.09.2022.
//

import UIKit

//Generic ListView....
class ListViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    private lazy var listViewModel: ListViewModel = ListViewModel()
    
    //Since the page is in Generic structure, you can check what information it comes with here.
    var initialComponent = Constant.ListViewControllerInitialComponent.baseDefatult
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initial()
        listTableViewInitial()
    }
    override func viewWillAppear(_ animated: Bool) {
        // This function is triggered when List Item is reloaded
        NotificationCenter.default.addObserver(self, selector: #selector(listItemsReload), name: Notification.Name("ListItemReloadData"), object: nil)
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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

private extension ListViewController{
    func initial(){
        titleLabel.text = listViewModel.initialListModel(initialComponent)
    }
}
private extension ListViewController{
    //This function is triggered when List Item is reloaded
    @objc func listItemsReload() {
        DispatchQueue.main.async {
            self.listTableView.reloadData()
        }
    }
}

private extension ListViewController{
    private func listTableViewInitial(){
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableViewRegister()
    }
    private func listTableViewRegister(){
        listTableView.register(UINib(nibName: "GlobalTableViewCell", bundle: nil), forCellReuseIdentifier: "GlobalTableViewCell")
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.getListItemCount()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToDetailViewController( listViewModel.didClickItem(at: indexPath.row, initialComponent))
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GlobalTableViewCell") as! GlobalTableViewCell
        if let cellData = listViewModel.getListCellData(indexPath: indexPath, initial: initialComponent) {
            cell.configureCellData(cellData)
            return cell
        }
        return cell
    }
}
