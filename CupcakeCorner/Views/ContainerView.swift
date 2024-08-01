//
//  ContainerView.swift
//  CupcakeCorner
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 31/07/24.
//

import SwiftUI

struct ContainerView: View {
    
    @State private var order = Order()
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity)
                }
                
                Section {
                    Toggle("Any special request?", isOn: $order.specialRequestEnabled)
                    
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink(value: 1) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
            .navigationDestination(for: Int.self) { _ in
                AddressView(path: $path, order: order)
            }
        }
    }
}

#Preview {
    ContainerView()
}
