//
//  HotelModel.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 4.10.2022.
//

// MARK: HotelModelProtocol
protocol HotelModelProtocol: AnyObject{
    func fetchHotels(onSuccess: @escaping (Hotel?) -> (), onError: @escaping (String?) -> ())
}

// MARK: HotelModel
final class HotelModel: HotelModelProtocol{
   // Fetch Hotels data
    func fetchHotels(onSuccess: @escaping (Hotel?) -> (), onError: @escaping (String?) -> ()) {
        // Service Manager Generic fethc data
        ServiceManager.shared.fetch(path: Constant.HotelServiceEndPoint.hotelGetEndPoint()) { (response: Hotel) in
            onSuccess(response) // if data success return response
        } onError: { error in
           onError(error)
        }
    }
    
}

