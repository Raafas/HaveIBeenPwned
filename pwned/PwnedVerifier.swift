//
//  PwnedVerifier.swift
//  pwned
//
//  Created by Rafael Leandro on 02/08/18.
//  Copyright © 2018 Rafael Leandro. All rights reserved.
//

import Foundation

public final class PwnedVerifier {
    
    public enum Result {
        case safe
        case error(error: Error?)
        case pwned(value: [Pwned])
    }
    
    public struct Pwned: Decodable {
        
        enum CodingKeys: String, CodingKey {
            case name = "Name"
            case breachDate = "BreachDate"
            case domain = "Domain"
            case datail = "Description"
        }
        
        var domain: String
        var name: String
        var beachDate: String
        var detail: String
        
        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            domain = try values.decode(String.self, forKey: .domain)
            name = try values.decode(String.self, forKey: .name)
            beachDate = try values.decode(String.self, forKey: .breachDate)
            detail = try values.decode(String.self, forKey: .datail)
        }
    }
    
    private let url: URL
    
    init(email: String) {
        guard let url = URL(string: "https://haveibeenpwned.com/api/v2/breachedaccount/\(email)") else {
            fatalError("invalid url")
        }
        
        self.url = url
    }
    
    func verify(completion: @escaping (Result) -> Void) {
        let task = URLSession.shared.dataTask(with: self.url) { [weak self] data, response, error in
            guard let `self` = self else { return }
            
            var result: Result
            
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            if let error = error {
                result = .error(error: error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                result = .error(error: nil)
                return
            }
            
            if response.statusCode == 404 {
                result = .safe
                return
            }
            
            guard let data = data else {
                result = .error(error: nil)
                return
            }
            
            result = self.present(with: data)
        }
        
        task.resume()
    }
    
    private func present(with data: Data) -> Result {
        do {
            let jsonDecoder = JSONDecoder()
            let pwned = try jsonDecoder.decode([Pwned].self, from: data)
            return .pwned(value: pwned)
            
        }  catch let error as NSError {
            fatalError(error.localizedDescription)
        }
        fatalError()
    }
    
}
