//
//  CodableContainerView.swift
//  CupcakeCorner
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 31/07/24.
//

import SwiftUI

struct CodableContainerView: View {
    var body: some View {
        Button(action: encodeTaylor, label: {
            Text("Encode Taylor")
        })
    }
    
    func encodeTaylor() {
        let data = try! JSONEncoder().encode(User())
        let str = String(decoding: data, as: UTF8.self)
        print(str)
    }
}

#Preview {
    CodableContainerView()
}
