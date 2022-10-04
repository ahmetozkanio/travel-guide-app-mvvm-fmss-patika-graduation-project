//
//  ListViewModel.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 4.10.2022.
//

import Foundation
/*
protocol ListViewModelProtocol:AnyObject{
    func getItemModel(_ itemModel: [Any])
}*/

final class ListViewModel{
    
    private let listViewController: ListViewController = ListViewController()
    
   
    lazy var hotelViewModel: HotelViewModel = HotelViewModel()
    
    var listItems = [Any]()
    
    
    init(){
        hotelViewModel.hotelListItemsDelegate = self
    }
    
    
    
    func initialListModel(_ initial: Constant.ListViewControllerInitialComponent ){
        switch initial {
        case .hotels:
             hotels()
        case .flights:
            print("flights")
        case .bookmarks:
            print("bookmarks")
        case .baseDefatult:
            print("baseDefatult")
        }
    }
}

extension ListViewModel{
    func didClickItem(at item: Int,_ initial: Constant.ListViewControllerInitialComponent) -> DetailEntity? {
        switch initial {
        case .hotels:
            let hotels: [HotelElement] = listItems as! [HotelElement]
            return DetailEntity(imageView: hotels[item].image, titleLabel:  hotels[item].price, mainTitleLabel:  hotels[item].name, descriptionLabel:  hotels[item].description)
        case .flights:
            print("flights")
        case .bookmarks:
            print("bookmarks")
        case .baseDefatult:
            print("baseDefatult")
        }
       return nil
    }
    
}

extension ListViewModel{
    func hotels(){
        hotelViewModel.didViewLoad()
    }
}
extension ListViewModel: HotelListItemsDelegate{
    func getHotelItems(_ items: [HotelElement]) {
        listItems = items
        NotificationCenter.default.post(name: Notification.Name("ListItemReloadData"), object: nil)
    }
}

extension ListViewModel{
    func getListItemCount() -> Int{
        return listItems.count
    }
    func getListCellData(indexPath: IndexPath, initial: Constant.ListViewControllerInitialComponent ) -> ListEntityGlobalTableViewCell? {
        switch initial {
        case .hotels:
            let hotels: [HotelElement] = listItems as! [HotelElement]
            return ListEntityGlobalTableViewCell(image: hotels[indexPath.row].image, title: hotels[indexPath.row].name, subTitle: hotels[indexPath.row].price )
        case .flights:
            print("flights")
        case .bookmarks:
            print("bookmarks")
        case .baseDefatult:
            print("baseDefatult")
        }
      
        return nil
       // return ListEntityGlobalTableViewCell(image: listItems[indexPath.row].image, title: listItems[indexPath.row].name, subTitle: listItems[indexPath.row].price)
    }
}
