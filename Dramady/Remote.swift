//
//  Remote.swift
//  Dramady
//
//  Created by User on 22.11.2021.
//

import Foundation
import Combine

class Remote<ResultData>: ObservableObject {
    @Published var isLoading = false
    @Published var data: ResultData?
    
    private var cancellableTask: AnyCancellable?
    let decode: (Data) throws -> ResultData
    let url: URL
    
    
    init(url: URL, decode: @escaping (Data) throws -> ResultData) {
        self.url = url
        self.decode = decode
    }
    
    func fetch() {
        isLoading = true
        //let jsonDecoder = JSONDecoder()
        
        cancellableTask = URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap{ element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .tryMap(decode)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                  self.isLoading = false
            }, receiveValue: { [weak self] data in
                self?.data = data
            })
            	
    }
}

extension Remote where ResultData: Decodable {
    convenience init(url: URL) {
        self.init(url: url) { data in
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            return try jsonDecoder.decode(ResultData.self, from: data)
        }
    }
}
