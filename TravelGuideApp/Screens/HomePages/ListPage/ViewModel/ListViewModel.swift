//
//  ListViewModel.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 4.10.2022.
//

import Foundation

final class ListViewModel{
    
    private let listViewController: ListViewController = ListViewController()

   
    lazy var hotelViewModel: HotelViewModel = HotelViewModel()
    lazy var flightViewModel: FlightViewModel = FlightViewModel()
    
    var listItems = [Any]()
    
    init(){
        hotelViewModel.hotelListItemsDelegate = self
        flightViewModel.flightListItemsDelegate = self
    }
    
    
    
    func initialListModel(_ initial: Constant.ListViewControllerInitialComponent ) -> String?{
        switch initial {
        case .hotels:
             hotels()
            return "Hotels"
        case .flights:
            flights()
            return "Flights"
        case .bookmarks:
            print("bookmarks")
        case .baseDefatult:
            print("baseDefatult")
        }
        return ""
    }
}

extension ListViewModel{
    func hotels(){
        hotelViewModel.didViewLoad()
       
    }
    func flights(){
        flightViewModel.didViewLoad()
       
    }
}

extension ListViewModel{
    func didClickItem(at item: Int,_ initial: Constant.ListViewControllerInitialComponent) -> DetailEntity? {
        switch initial {
        case .hotels:
            let hotels: [HotelElement] = listItems as! [HotelElement]
            return DetailEntity(imageView: hotels[item].image, titleLabel:  hotels[item].price, mainTitleLabel:  hotels[item].name, descriptionLabel:  hotels[item].description)
        case .flights:
            let flights: [FlightElement] = listItems as! [FlightElement]
            return DetailEntity(imageView: flights[item].image, titleLabel: "Flight Number : \(flights[item].flightNumber ?? "")", mainTitleLabel:   "\(flights[item].flightCompany ?? "")  -   \(flights[item].flightTitle ?? "")      ", descriptionLabel:  "Price : \(flights[item].price ?? "") - \(flights[item].day ?? "") -  \(flights[item].departAirport ?? "") -> \(flights[item].arrivalAirport ?? "")")
        case .bookmarks:
            print("bookmarks")
        case .baseDefatult:
            print("baseDefatult")
        }
       return nil
    }
    
}

extension ListViewModel: HotelListItemsDelegate{
    func getHotelItems(_ items: [HotelElement]) {
        listItems = items
        NotificationCenter.default.post(name: Notification.Name("ListItemReloadData"), object: nil)
    }
}
extension ListViewModel: FlightListItemsDelegate{
    func getFlightItems(_ items: [FlightElement]) {
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
            let flights: [FlightElement] = listItems as! [FlightElement]
            return ListEntityGlobalTableViewCell(image: flights[indexPath.row].image, title: flights[indexPath.row].flightTitle, subTitle: flights[indexPath.row].flightCompany )
        case .bookmarks:
            print("bookmarks")
        case .baseDefatult:
            print("baseDefatult")
        }
      
        return nil
      
    }
}
