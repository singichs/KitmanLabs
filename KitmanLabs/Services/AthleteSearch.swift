//
//  AthleteSearch.swift
//  KitmanLabs
//

import Foundation

extension ContentService {
    
    func retrieveAthletes(completionHandler: @escaping ([Athlete]) -> Void) {
        
        let request = constructRequest(for: .athletes)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                return
            }
            
            var results = [Athlete]()
            if let data = data {
                do {
                    results = try JSONDecoder().decode([Athlete].self, from: data)
                } catch let error as NSError {
                    print("Error: ", error.localizedDescription)
                }
            }
            
            completionHandler(results)
        }
        
        task.resume()
    }
    
    func retrieveSquad(completionHandler: @escaping ([Squad]) -> Void) {
        
        let request = constructRequest(for: .squads)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                return
            }
            
            var results = [Squad]()
            if let data = data {
                do {
                    results = try JSONDecoder().decode([Squad].self, from: data)
                } catch let error as NSError {
                    print("Error: ", error.localizedDescription)
                }
            }
            
            completionHandler(results)
        }
        
        task.resume()
    }

}
