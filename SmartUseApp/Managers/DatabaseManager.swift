//
//  DatabaseManager.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 27.05.2022.
//

import Foundation
import FirebaseDatabase

class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    let database = Database.database().reference()
    
    private init() {}
}
