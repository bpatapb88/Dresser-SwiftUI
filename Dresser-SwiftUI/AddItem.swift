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
    @State private var photoPath = ""
    
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    
    let warms = ["Легкое", "Среднее", "Теплое"]
    let types = ["Верхняя одежда", "Средний слой", "Нательная одежда", "Низ", "Обувь"]
    var body: some View {
        NavigationView{
            Form{
                TextField("Name", text: $name)
                Picker("Type", selection: $type){
                    ForEach(self.types, id: \.self){
                        Text($0)
                    }
                }.pickerStyle(.menu)
                Picker("Warm", selection: $warm){
                    ForEach(self.warms, id: \.self){
                        Text($0)
                    }
                }.pickerStyle(.segmented)
                TextField("Brand", text: $brand)
                Button(action: {
                    self.isShowPhotoLibrary = true
                }){
                
                        Image(uiImage: self.image)
                            .resizable()
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            
                    
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                
            }
            .navigationBarTitle("Add Item")
            .navigationBarItems(trailing: Button("Save"){
                if self.name != "" {
                    savePng(self.image)
                    items.items.append(Item(name: self.name, type: self.type, brand: self.brand, warm: warms.firstIndex(of: self.warm)!, photoPath: self.photoPath))
                        self.presentationMode.wrappedValue.dismiss()
                }
            })
        }.sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        }
    }
    func documentDirectoryPath() -> URL? {
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        return path.first
    }
    
    func savePng(_ image: UIImage) {
        if let pngData = image.pngData(),
            let path = documentDirectoryPath()?.appendingPathComponent("examplePng.png") {
            try? pngData.write(to: path)
            self.photoPath = path.relativePath
            print("Image was saved \(path.relativePath)")
            print("Image was saved \(path.absoluteString)")
            
        }
    }
}

struct AddItem_Previews: PreviewProvider {
    static var previews: some View {
        AddItem(items: Items())
    }
}
