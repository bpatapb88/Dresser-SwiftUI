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
    @State private var showingAddItem = false
    @State private var toBeDeleted: IndexSet?
    @ObservedObject var itemList = Items()
    
    var body: some View {
        TabView{
            VStack{
                NavigationView{
                    List{
                        ForEach (itemList.items){ item in
                            NavigationLink(destination: ItemView(item: item)){
                                HStack{
                                    VStack{
                                        Text(item.name)
                                            .font(.headline.weight(.bold))
                                        Text(item.brand)
                                    }
                                    Spacer()
                                    Text(item.type)
                                }
                                
                                    .alert(isPresented: self.$showingDeleteAlert) {
                                        Alert(title: Text("Are you sure"), message: Text("want to delete \(item.name)?"), primaryButton: .destructive(Text("Delete")) {
                                            if let toBeDeletedSet:IndexSet = toBeDeleted {
                                                for index in toBeDeletedSet {
                                                    itemList.items.remove(at: index)
                                                }
                                                self.toBeDeleted = nil
                                            }
                                        }, secondaryButton: .cancel() {
                                            self.toBeDeleted = nil
                                        })
                                    }
                            }
                        } .onDelete(perform: deleteRow)
                        
                    }
                    .listStyle(GroupedListStyle())
                    .navigationBarTitle("Garderob")
                    .navigationBarItems(trailing: Button(action: {
                        self.showingAddItem = true
                    }){
                        Image(systemName: "plus")
                    })
                    .sheet(isPresented: $showingAddItem){
                        AddItem(items: self.itemList)
                    }
                    
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

