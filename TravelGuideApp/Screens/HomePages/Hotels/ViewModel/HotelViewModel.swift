//
//  HotelViewModel.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 4.10.2022.
//

import Foundation

protocol HotelViewModelProtocol: AnyObject{
    func reloadHotelData()
}
protocol HotelListItemsDelegate: AnyObject{
    func getHotelItems(_ items: [HotelElement])
}

final class HotelViewModel{
    private let hotelService: HotelModelProtocol = HotelModel()
    weak var delegate: HotelViewModelProtocol?
    weak var hotelListItemsDelegate: HotelListItemsDelegate?
    lazy var hotelItems: [HotelElement] = []
   //  var listViewModelDelegate: ListViewModelProtocol = ListViewModel()
    func didViewLoad(){
        
        initHotelService()
    }
}

extension HotelViewModel{
    
    func initHotelService(){
        hotelService.fetchHotels {[weak self] (model) in
            //self?.hotelItems = model?.hotels ?? []
            print("HotelItems")
            self?.hotelListItemsDelegate?.getHotelItems(model?.hotels ?? [])
            // self?.listViewModelDelegate.getItemModel(model?.hotels ?? [])
           //self?.delegate?.reloadHotelData()
        } onError: { error in
            print(error ?? "Error initArticleService")
        }
        
    }
}
