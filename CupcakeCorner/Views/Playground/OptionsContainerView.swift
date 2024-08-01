//
//  OptionsContainerView.swift
//  CupcakeCorner
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 31/07/24.
//

import SwiftUI

enum Routes {
    case codable
    case haptics
    case customHaptics
    case urlSession
    case form
}

struct OptionsContainerView: View {
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(value: Routes.codable) {
                    Text("Codable")
                }
                NavigationLink(value: Routes.haptics) {
                    Text("Simple Haptics")
                }
                NavigationLink(value: Routes.customHaptics) {
                    Text("Custom Haptics")
                }
                NavigationLink(value: Routes.urlSession) {
                    Text("URLSession")
                }
                NavigationLink(value: Routes.form) {
                    Text("Form")
                }
            }
            .navigationDestination(for: Routes.self) { route in
                switch route {
                case .codable:
                    CodableContainerView()
                case .haptics:
                    HapticsView()
                case .customHaptics:
                    CustomHapticsView()
                case .urlSession:
                    URLSessionView()
                case .form:
                    FormContentView()
                }
            }
        }
    }
}

#Preview {
    OptionsContainerView()
}
