//
//  FlightViewModel.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 4.10.2022.
//

import Foundation


// MARK: FlightViewModel Protocols
protocol FlightViewModelProtocol: AnyObject{
    func reloadFlightData()
}
protocol FlightListItemsDelegate: AnyObject{
    func getFlightItems(_ items: [FlightElement])
}

// MARK: FlightViewModel
final class FlightViewModel{
    
    private let flightService: FlightModelProtocol = FlightModel()
    weak var delegate: FlightViewModelProtocol?
    weak var flightListItemsDelegate: FlightListItemsDelegate?
    
    func didViewLoad(){
        initFlightService()
    }
}

// MARK: FlightViewModel Entensions
extension FlightViewModel{
    // Initial flight data is call
    func initFlightService(){
        flightService.fetchFlights {[weak self] (model) in
            self?.flightListItemsDelegate?.getFlightItems(model?.flights ?? [])
        } onError: { error in
            print(error ?? "Error initFlightService")
        }
        
    }
}
