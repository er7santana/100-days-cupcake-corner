//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 31/07/24.
//

import SwiftUI

struct AddressView: View {
    
    @Binding var path: NavigationPath
    @Bindable var order: Order
    
    init(path: Binding<NavigationPath>, order: Order) {
        self._path = path
        self.order = order
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            
            Section {
                NavigationLink("Check out") {
                    CheckoutView(path: $path, order: order)
                }
                .disabled(order.hasValidAddress == false)
            }
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        AddressView(path: .constant(NavigationPath()), order: Order())
    }
}
