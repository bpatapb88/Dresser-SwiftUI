//
//  ContentView.swift
//  Dresser-SwiftUI
//
//  Created by Semen Simanov on 30.08.2022.
//

import SwiftUI
import RealmSwift


struct ContentView: View {
    
    @State private var itemsTop = ["Tshirt", "Coat", "Blazer"]
    @State private var showingDeleteAlert = false
    @State private var toBeDeleted: IndexSet?
    
    var body: some View {
        TabView{
            VStack{
                NavigationView{
                    List{
                        ForEach (itemsTop, id: \.self){ item in
                            Text(item)
                                .alert(isPresented: self.$showingDeleteAlert) {
                                    Alert(title: Text("Are you sure"), message: Text("want to delete \(itemsTop[toBeDeleted!.first!])?"), primaryButton: .destructive(Text("Delete")) {
                                        if let toBeDeletedSet:IndexSet = toBeDeleted {
                                            for index in toBeDeletedSet {
                                                itemsTop.remove(at: index)
                                            }
                                            self.toBeDeleted = nil
                                        }
                                    }, secondaryButton: .cancel() {
                                        self.toBeDeleted = nil
                                    })
                                }
                        } .onDelete(perform: deleteRow)
                        
                    }
                    .listStyle(GroupedListStyle())
                    .navigationBarTitle("Garderob")
                    .navigationBarItems(trailing: Button(action: {
                        print("Add button pressed")
                        itemsTop.append("New Item")
                    }){
                        Text("Add")
                    })
                    
                }
            }.tabItem{
                Image(systemName: "tshirt")
                Text("Items")
            }
            
            VStack{
                Text("Looks views")
            }.tabItem{
                Image(systemName: "list.bullet")
                Text("Looks")
            }
        }
    }
    func deleteRow(at indexSet: IndexSet) {
        self.toBeDeleted = indexSet           // store rows for delete
        self.showingDeleteAlert = true
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

