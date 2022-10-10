//
//  ListViewModel.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 4.10.2022.
//

import Foundation

final class ListViewModel{
    
    private let listViewController: ListViewController = ListViewController()
    private lazy var hotelViewModel: HotelViewModel = HotelViewModel()
    private lazy var flightViewModel: FlightViewModel = FlightViewModel()
    private var listItems = [Any]()
    
    init(){
        hotelViewModel.hotelListItemsDelegate = self
        flightViewModel.flightListItemsDelegate = self
    }
    
    // ListView Function that determines which model to trigger at startup. Return Title Label/
    func initialListModel(_ initial: Constant.ListViewControllerInitialComponent ) -> String?{
        switch initial {
        case .hotels:
            hotelViewModel.didViewLoad() // Hotels is Call
            return "Hotels"
        case .flights:
            flightViewModel.didViewLoad() // Flights is Call
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
    func didClickItem(at item: Int,_ initial: Constant.ListViewControllerInitialComponent) -> DetailEntity? {
        switch initial {
            
        case .hotels: // The index hotel list in the clicked list is entered here and filled and sent in accordance with the hotel data and the model of the detail page.
            let hotels: [HotelElement] = listItems as! [HotelElement]
            return DetailEntity(imageView: hotels[item].image, titleLabel:  hotels[item].price, mainTitleLabel:  hotels[item].name, descriptionLabel:  hotels[item].description)
            
        case .flights: // The index flight list in the clicked list is entered here and filled and sent in accordance with the flight data and the model of the detail page.
            let flights: [FlightElement] = listItems as! [FlightElement]
            return DetailEntity(imageView: flights[item].image, titleLabel: "Flight Number : \(flights[item].flightNumber ?? "")", mainTitleLabel: "\(flights[item].flightCompany ?? "")  -   \(flights[item].flightTitle ?? "")      ", descriptionLabel:  "Price : \(flights[item].price ?? "") - \(flights[item].day ?? "") -  \(flights[item].departAirport ?? "") -> \(flights[item].arrivalAirport ?? "")")
            
        case .bookmarks:
            print("bookmarks")
        case .baseDefatult:
            print("baseDefatult")
        }
        return nil
    }
}
// If data comes from the hotel delegate and the function called in the initial, this will be triggered and our list will be ready.
extension ListViewModel: HotelListItemsDelegate{
    func getHotelItems(_ items: [HotelElement]) {
        listItems = items
        NotificationCenter.default.post(name: Notification.Name("ListItemReloadData"), object: nil)
    }
}
// If data comes from the flight delegate and the function called in the initial, this will be triggered and our list will be ready.
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
    // This function fills the table View Cell with the appropriate entity according to the model and sends it to the list
    func getListCellData(indexPath: IndexPath, initial: Constant.ListViewControllerInitialComponent ) -> ListEntityGlobalTableViewCell? {
        
        switch initial {
        case .hotels:
            let hotels: [HotelElement] = listItems as! [HotelElement]
            return ListEntityGlobalTableViewCell(
                image: hotels[indexPath.row].image,
                title: hotels[indexPath.row].name,
                subTitle: hotels[indexPath.row].price,
                tagName: nil
            )
        case .flights:
            let flights: [FlightElement] = listItems as! [FlightElement]
            return ListEntityGlobalTableViewCell(image: flights[indexPath.row].image, title: flights[indexPath.row].flightTitle, subTitle: flights[indexPath.row].flightCompany,
                                                 tagName: nil
            )
        case .bookmarks:
            print("bookmarks")
        case .baseDefatult:
            print("baseDefatult")
        }
        return nil
        
    }
}
