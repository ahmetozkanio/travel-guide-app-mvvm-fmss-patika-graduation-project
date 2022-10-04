//
//  FlightViewModel.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 4.10.2022.
//

import Foundation



protocol FlightViewModelProtocol: AnyObject{
    func reloadFlightData()
}
protocol FlightListItemsDelegate: AnyObject{
    func getFlightItems(_ items: [FlightElement])
}

final class FlightViewModel{
    private let flightService: FlightModelProtocol = FlightModel()
    weak var delegate: FlightViewModelProtocol?
    weak var flightListItemsDelegate: FlightListItemsDelegate?
   // lazy var flightItems: [FlightElement] = []
   
    func didViewLoad(){
        
        initFlightService()
    }
}

extension FlightViewModel{
    
    func initFlightService(){
       flightService.fetchFlights {[weak self] (model) in
            print("FlightItems")
            self?.flightListItemsDelegate?.getFlightItems(model?.flights ?? [])
        } onError: { error in
            print(error ?? "Error initFlightService")
        }
        
    }
}
