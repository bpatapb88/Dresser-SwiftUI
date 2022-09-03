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
        Text("Choosed item \(item.name)")
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(item: Item(name: "Tshirt", type: "", brand: "", warm: 2))
    }
}
