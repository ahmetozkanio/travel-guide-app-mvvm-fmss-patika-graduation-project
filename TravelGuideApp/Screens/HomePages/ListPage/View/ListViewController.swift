//
//  ListViewController.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 30.09.2022.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       listTableViewInitial()
    }
    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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

extension ListViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GlobalTableViewCell")!
        return cell
    }

    
}
