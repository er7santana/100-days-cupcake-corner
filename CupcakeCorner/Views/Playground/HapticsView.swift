//
//  HapticsView.swift
//  CupcakeCorner
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 31/07/24.
//

import SwiftUI

struct HapticsView: View {
    
    @State private var counter = 0
    
    var body: some View {
        Button("Tap count: \(counter)") {
            counter += 1
        }
        .sensoryFeedback(.increase, trigger: counter)
    }
}

#Preview {
    HapticsView()
}
