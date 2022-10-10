//
//  BookmarksViewController.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 27.09.2022.
//

import UIKit

class BookmarksViewController: UIViewController {
    
    @IBOutlet weak var bookmarksTableView: UITableView!
    
    private lazy var bookmarksViewModel: BookmarksViewModel = BookmarksViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookmarksViewModel.delegate = self
        bookmarksViewModel.didViewLoad()
        bookmarksTableViewInitial()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(bookmarksAddAndRemoveData), name: Notification.Name("reloadBookmarksData"), object: nil)
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
extension BookmarksViewController{
    @objc func bookmarksAddAndRemoveData(){
        bookmarksViewModel.addAndRemoveProcess()
    }
}
extension BookmarksViewController:BookmarksViewModelProtocol {
    func reloadBookmarks() {
        DispatchQueue.main.async {
            self.bookmarksTableView.reloadData()
        }
    }
}


private extension BookmarksViewController{
    private func bookmarksTableViewInitial(){
        bookmarksTableView.delegate = self
        bookmarksTableView.dataSource = self
        bookmarksTableViewRegister()
    }
    private func bookmarksTableViewRegister(){
        bookmarksTableView.register(UINib(nibName: "GlobalTableViewCell", bundle: nil), forCellReuseIdentifier: "GlobalTableViewCell")
    }
}

extension BookmarksViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarksViewModel.getListItemCount()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToDetailViewController(bookmarksViewModel.didClickItem(at: indexPath.row))
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GlobalTableViewCell") as! GlobalTableViewCell
        
        if let cellData = bookmarksViewModel.getListCellData(indexPath: indexPath) {
            cell.configureCellData(cellData)
            return cell
        }
        return cell
    }
}
