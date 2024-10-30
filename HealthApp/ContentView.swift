//
//  ContentView.swift
//  HealthApp
//
//  Created by Aitor on 29/10/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("hasLaunchedBefore") var hasLaunchedBefore: Bool = false
    
    var body: some View {
        VStack {
            if !hasLaunchedBefore {
                Button(action: {
                    hasLaunchedBefore = true
                }) {
                    Text("Entrar a la app")
                        .font(.largeTitle)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            } else {
                HealthPermissionView() // Vista para pedir permisos
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
