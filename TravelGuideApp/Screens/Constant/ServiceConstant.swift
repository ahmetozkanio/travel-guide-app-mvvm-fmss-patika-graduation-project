//
//  ServiceConstant.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 2.10.2022.
//
//

//https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=54c017307b434df1a0b757b75c17bfa4

import Foundation

extension Constant{
    
    enum ArticleServiceEndPoint: String{
        case BASE_URL = "https://newsapi.org/v2/top-headlines?sources=techcrunch"
        case API_KEY = "&apiKey=54c017307b434df1a0b757b75c17bfa4"
        
        static func articleGetEndPoint() -> String{
            "\(BASE_URL.rawValue)\(API_KEY.rawValue)"
        }
    }
    enum HotelServiceEndPoint: String{
        case BASE_URL = "https://raw.githubusercontent.com/"
        case END_URL = "ahmetozkanio/custom-api-public/main/hotel-json-api.json"
        static func hotelGetEndPoint() -> String{
            "\(BASE_URL.rawValue)\(END_URL.rawValue)"
        }
    }
    enum FlightServiceEndPoint: String{
        case BASE_URL = "https://raw.githubusercontent.com/"
        case END_URL = "ahmetozkanio/custom-api-public/main/flight-json-api.json"
        static func flightGetEndPoint() -> String{
            "\(BASE_URL.rawValue)\(END_URL.rawValue)"
        }
    }
}
