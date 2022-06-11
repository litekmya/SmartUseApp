//
//  NetworkManager.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 09.06.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func getImage(from urlString: String, completion: @escaping(Data) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Ошибка в NetworkManager/getImage")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Ошибка в NetworkManager/URLSession: \(error)")
                return
            }
            
            guard let data = data else {
                print(print("Ошибка в NetworkManager/URLSession/data"))
                return
            }
            
            DispatchQueue.main.async {
                completion(data)
            }
        }.resume()
    }
}
