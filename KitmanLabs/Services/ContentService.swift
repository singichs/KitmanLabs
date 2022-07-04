//
//  ContentService.swift
//  KitmanLabs
//

import Foundation

class ContentService {
    
    public enum Endpoint: String {
        case athletes = "/athletes"
        case squads = "/squads"
    }
    
    func constructRequest(for endpoint: Endpoint) -> URLRequest {
        let path = endpoint.rawValue
        let url = URL(string: "https://kml-tech-test.glitch.me" + path)
        
        guard let requestUrl = url else {
            fatalError()
        }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        return request
    }

}
