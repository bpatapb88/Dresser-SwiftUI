//
//  SwiftUIView.swift
//  Dresser-SwiftUI
//
//  Created by Semen Simanov on 03.09.2022.
//

import SwiftUI

struct ItemView: View {
    var item: Item
    
    var body: some View {
        VStack{
            Text("Choosed item \(item.name)")
            Image(uiImage: loadImageFromDiskWith(fileName: item.photoPath ) ?? UIImage())
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 5))
        }
    }
    
    func loadImageFromDiskWith(fileName: String) -> UIImage? {
        let image = UIImage(contentsOfFile: fileName)
                if image == nil {
                    print("No images!")
                    print("fileName \(fileName)")
                    return UIImage()
                } else{
                    print("Image send!")
                    return image
                }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(item: Item(name: "Tshirt", type: "", brand: "", warm: 2, photoPath: ""))
    }
}
