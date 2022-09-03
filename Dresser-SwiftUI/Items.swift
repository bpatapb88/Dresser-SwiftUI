//
//  Items.swift
//  Dresser-SwiftUI
//
//  Created by Semen Simanov on 03.09.2022.
//

import Foundation

struct Item: Identifiable, Codable{
    var id = UUID()
    let name: String
    let type: String
    let brand: String
    let warm: Int
}

class Items : ObservableObject{
    @Published var items = [Item](){
        didSet{
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init(){
        if let items = UserDefaults.standard.data(forKey: "Items"){
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Item].self, from: items){
                self.items = decoded
                return
            }
        }
    }
}
