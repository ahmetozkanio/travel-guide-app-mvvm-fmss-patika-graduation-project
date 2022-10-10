//
//  FlightModel.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 4.10.2022.
//

// MARK: Flight Model Protocol
protocol FlightModelProtocol: AnyObject{
    func fetchFlights(onSuccess: @escaping (Flight?) -> (), onError: @escaping (String?) -> ())
}

// MARK: Flight Model
final class FlightModel: FlightModelProtocol{
    // Flight api data fetch call
    func fetchFlights(onSuccess: @escaping (Flight?) -> (), onError: @escaping (String?) -> ()) {
        // Generic fetch service
        ServiceManager.shared.fetch(path: Constant.FlightServiceEndPoint.flightGetEndPoint()) { (response: Flight) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }
}

