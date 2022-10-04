//
//  HotelModel.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 4.10.2022.
//


protocol HotelModelProtocol: AnyObject{
    func fetchHotels(onSuccess: @escaping (Hotel?) -> (), onError: @escaping (String?) -> ())
}

final class HotelModel: HotelModelProtocol{
   
    func fetchHotels(onSuccess: @escaping (Hotel?) -> (), onError: @escaping (String?) -> ()) {
        ServiceManager.shared.fetch(path: Constant.HotelServiceEndPoint.hotelGetEndPoint()) { (response: Hotel) in
            onSuccess(response)
        } onError: { error in
           onError(error)
        }
    }
    
}

