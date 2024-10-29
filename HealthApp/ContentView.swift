//
//  ContentView.swift
//  HealthApp
//
//  Created by Aitor on 29/10/24.
//

import SwiftUI
import HealthKit

let healthStore = HKHealthStore()

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Health App")
                    .font(.largeTitle)
                    .padding()
            }
            .onAppear {
                requestHealthKitAuthorization()
            }
            .navigationTitle("Health Dashboard")
        }
    }
    
  
    
    
    
    
    
    
    private func requestHealthKitAuthorization() {
        let healthTypesToRead: Set = [
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.quantityType(forIdentifier: .heartRate)!,
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
        ]
        
        healthStore.requestAuthorization(toShare: nil, read: healthTypesToRead) { (success, error) in
            if success {
                print("Permisos concedidos para HealthKit")
            } else {
                print("Permisos denegados: \(error?.localizedDescription ?? "")")
            }
        }
    }
}
