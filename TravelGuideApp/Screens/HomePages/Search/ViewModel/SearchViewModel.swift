//
//  SearchViewModel.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 5.10.2022.
//

import Foundation

final class SearchViewModel{
    
    private lazy var hotelViewModel: HotelViewModel = HotelViewModel()
    private lazy var flightViewModel: FlightViewModel = FlightViewModel()
        
    var listItems = [Any]()
    var searchListItems = [Any]()
    var searching:Bool = false

    init(){
        hotelViewModel.hotelListItemsDelegate = self
        flightViewModel.flightListItemsDelegate = self
    }
    func initialSearchListModel(_ initial: Constant.SearchModel ){
         switch initial {
         case .hotels:
             hotelViewModel.didViewLoad()
         case .flights:
             flightViewModel.didViewLoad()
         }
     }
}

extension SearchViewModel{
    func searchFilter(_ queryText: String,_ initial: Constant.SearchModel){
        switch initial {
        case .hotels:
            hotelFilter(queryText)
        case .flights:
            flightFilter(queryText)
        }
    }
    func hotelFilter(_ queryText: String){
   
        let hotels: [HotelElement] = listItems as! [HotelElement]
        searchListItems = hotels.filter({ (result) -> Bool in
            return result.name?.range(of: queryText, options: .caseInsensitive) != nil
        })
        
    }
    func flightFilter(_ queryText: String){
   
   
        let flights: [FlightElement] = listItems as! [FlightElement]
        searchListItems = flights.filter({ (result) -> Bool in
            return result.flightNumber?.range(of: queryText, options: .caseInsensitive) != nil
        })
        
    }
}

extension SearchViewModel: HotelListItemsDelegate{
    func getHotelItems(_ items: [HotelElement]) {
        listItems = items
        searchListItems.removeAll()
        NotificationCenter.default.post(name: Notification.Name("SearchListItemReloadData"), object: nil)
    }
}
extension SearchViewModel: FlightListItemsDelegate{
    func getFlightItems(_ items: [FlightElement]) {
        listItems = items
        searchListItems.removeAll()
       NotificationCenter.default.post(name: Notification.Name("SearchListItemReloadData"), object: nil)
    }
}

extension SearchViewModel{
    func didClickItem(at item: Int,_ initial: Constant.SearchModel) -> DetailEntity? {
        switch initial {
        case .hotels:
            let hotels: [HotelElement] = searchListItems as! [HotelElement]
            return DetailEntity(imageView: hotels[item].image, titleLabel:  hotels[item].price, mainTitleLabel:  hotels[item].name, descriptionLabel:  hotels[item].description)
        case .flights:
            let flights: [FlightElement] = searchListItems as! [FlightElement]
            return DetailEntity(imageView: flights[item].image, titleLabel: "Flight Number : \(flights[item].flightNumber ?? "")", mainTitleLabel: "\(flights[item].flightCompany ?? "")  -   \(flights[item].flightTitle ?? "")      ", descriptionLabel:  "Price : \(flights[item].price ?? "") - \(flights[item].day ?? "") -  \(flights[item].departAirport ?? "") -> \(flights[item].arrivalAirport ?? "")")
        }
    
    }
    
}
extension SearchViewModel{
    func getListItemCount() -> Int{
        return searchListItems.count
    }
    func getSearchListCellData(indexPath: IndexPath, initial: Constant.SearchModel ) -> ListEntityGlobalTableViewCell? {
        switch initial {
        case .hotels:
            let hotels: [HotelElement] = searchListItems as! [HotelElement]
            if !hotels.isEmpty {
                return ListEntityGlobalTableViewCell(image: hotels[indexPath.row].image, title: hotels[indexPath.row].name, subTitle: hotels[indexPath.row].price )
            }
           
        case .flights:
            
            let flights: [FlightElement] = searchListItems as! [FlightElement]
            if !flights.isEmpty {
            return ListEntityGlobalTableViewCell(image: flights[indexPath.row].image, title: flights[indexPath.row].flightTitle, subTitle: flights[indexPath.row].flightCompany )
            }
        }

        return nil
    }
}
