//
//  ImageProvider.swift
//  KitmanLabs
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImage(from url: String) {
        guard let url = URL(string: url) else {
            return
        }
        
        downloadImage(from: url)
    }
    
    private func downloadImage(from url: URL) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                return
            }
            
            if let data = data {
                let image = UIImage(data: data)
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {
                        return
                    }
                    self.image = image
                }
            }
        }
        
        task.resume()
    }
}
