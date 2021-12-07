//
//  ImageFetcher.swift
//  Dramady
//
//  Created by User on 28.11.2021.
//

import Foundation
import UIKit

class ImageFetcher: ObservableObject {
    @Published var image: UIImage = UIImage()
    
    func loadImage(for urlString: String) {
            guard let url = URL(string: urlString) else { return }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.image = UIImage(data: data) ?? UIImage()
                }
            }
            task.resume()
        }
}
