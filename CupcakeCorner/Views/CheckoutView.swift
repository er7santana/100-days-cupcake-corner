//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 31/07/24.
//

import SwiftUI

struct CheckoutView: View {
    
    @Binding var path: NavigationPath
    @Bindable var order: Order
    
    init(path: Binding<NavigationPath>, order: Order) {
        self._path = path
        self.order = order
    }
    
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.cost, format: .currency(code: "BRL"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .alert("Thank you", isPresented: $showingConfirmation) {
            Button("OK") {
                order.clearValues()
                path = NavigationPath()
            }
        } message: {
            Text(confirmationMessage)
        }
        .alert("Oops", isPresented: $showingError) {
            Button("OK") { }
        } message: {
            Text(errorMessage)
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize) // With that in place we'll get nice scroll bouncing when we have actually scrolling content, otherwise the scroll view acts like it isn't even there.
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            print("Checkout failed: \(error.localizedDescription)")
            errorMessage = "Checkout failed"
            showingError = true
        }
    }
}

#Preview {
    CheckoutView(path: .constant(NavigationPath()), order: Order())
}
