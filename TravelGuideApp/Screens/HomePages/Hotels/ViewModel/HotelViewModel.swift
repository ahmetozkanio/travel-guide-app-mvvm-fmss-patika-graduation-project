//
//  HotelViewModel.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 4.10.2022.
//

import Foundation
// MARK: HotelViewModelProtocol
protocol HotelViewModelProtocol: AnyObject{
    func reloadHotelData()
}
protocol HotelListItemsDelegate: AnyObject{
    func getHotelItems(_ items: [HotelElement])
}

// MARK: HotelViewModel
final class HotelViewModel{
    
    private let hotelService: HotelModelProtocol = HotelModel()
    weak var delegate: HotelViewModelProtocol?
    weak var hotelListItemsDelegate: HotelListItemsDelegate?
    lazy var hotelItems: [HotelElement] = []
    
    func didViewLoad(){
        initHotelService()
    }
}

// MARK: HotelViewModel Extension
extension HotelViewModel{
    
    // Initial hotel service is call
    func initHotelService(){
        hotelService.fetchHotels {[weak self] (model) in
            self?.hotelListItemsDelegate?.getHotelItems(model?.hotels ?? [])
        } onError: { error in
            print(error ?? "Error initFlightService")
        }
        
    }
}
