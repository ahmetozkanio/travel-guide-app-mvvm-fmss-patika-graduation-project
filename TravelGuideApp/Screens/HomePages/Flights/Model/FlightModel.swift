//
//  FlightModel.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 4.10.2022.
//

protocol FlightModelProtocol: AnyObject{
    func fetchFlights(onSuccess: @escaping (Flight?) -> (), onError: @escaping (String?) -> ())
}

final class FlightModel: FlightModelProtocol{
   
    func fetchFlights(onSuccess: @escaping (Flight?) -> (), onError: @escaping (String?) -> ()) {
        ServiceManager.shared.fetch(path: Constant.FlightServiceEndPoint.flightGetEndPoint()) { (response: Flight) in
            onSuccess(response)
        } onError: { error in
           onError(error)
        }
    }
}

