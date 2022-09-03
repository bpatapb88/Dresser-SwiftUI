//
//  AddItem.swift
//  Dresser-SwiftUI
//
//  Created by Semen Simanov on 03.09.2022.
//

import SwiftUI

struct AddItem: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var items: Items
    @State private var name = ""
    @State private var type = ""
    @State private var brand = ""
    @State private var warm = "Легкое"
    
    let warms = ["Легкое", "Среднее", "Теплое"]
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Name", text: $name)
                TextField("Type", text: $type)
                Picker("Warm", selection: $warm){
                    ForEach(self.warms, id: \.self){
                        Text($0)
                    }
                }.pickerStyle(.segmented)
                TextField("Brand", text: $brand)
                
            }
            .navigationBarTitle("Add Item")
            .navigationBarItems(trailing: Button("Save"){
                
                items.items.append(Item(name: self.name, type: self.type, brand: self.brand, warm: warms.firstIndex(of: self.warm)!))
                    self.presentationMode.wrappedValue.dismiss()
                
            })
        }
    }
}

struct AddItem_Previews: PreviewProvider {
    static var previews: some View {
        AddItem(items: Items())
    }
}
