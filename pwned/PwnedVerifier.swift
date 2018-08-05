//
//  PwnedVerifier.swift
//  pwned
//
//  Created by Rafael Leandro on 02/08/18.
//  Copyright © 2018 Rafael Leandro. All rights reserved.
//

import Foundation

public final class PwnedVerifier {
    private let url: URL
    
    init(email: String) {
        guard let url = URL(string: "https://haveibeenpwned.com/api/v2/breachedaccount/\(email)") else {
            fatalError("invalid url")
        }
        
        self.url = url
    }
    
    func verify(completion: @escaping (Data) -> Void) {
        let task = URLSession.shared.dataTask(with: self.url) { (data, response, error) in
            
            if let data = data {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String : Any]] else { fatalError() }
                    for value in json {
                        print(TerminalUtils().AnsiString(value: value["Name"]! as! String, color: TerminalUtils.color.red, style: TerminalUtils.style.bold))
                    }
                }  catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
}
