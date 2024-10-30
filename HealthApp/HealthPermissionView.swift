//
//  HealthPermissionView.swift
//  HealthApp
//
//  Created by Aitor on 30/10/24.
//
import SwiftUI
import HealthKit

struct HealthPermissionView: View {
    @State private var isAuthorized: Bool? = nil // Opcional para estado indefinido
    private var healthStore = HKHealthStore()
    
    var body: some View {
        VStack {
            if let isAuthorized = isAuthorized {
                if isAuthorized {
                    Text("Permisos concedidos")
                        .font(.largeTitle)
                        .padding()
                } else {
                    Text("Permisos denegados o no solicitados")
                        .font(.largeTitle)
                        .padding()
                    Button(action: requestHealthPermission) {
                        Text("Solicitar Permisos")
                            .font(.title)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .onAppear {
                        checkAuthorization()
                    }
            }
        }
    }
    
    private func checkAuthorization() {
        // Definir algunos tipos básicos de HealthKit para comprobar la autorización
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else {
            isAuthorized = false
            return
        }
        
        let status = healthStore.authorizationStatus(for: heartRateType)
        
        DispatchQueue.main.async {
            switch status {
            case .notDetermined:
                self.isAuthorized = false
            case .sharingAuthorized:
                self.isAuthorized = true
            case .sharingDenied:
                self.isAuthorized = false
            @unknown default:
                self.isAuthorized = false
            }
        }
    }
    
    private func requestHealthPermission() {
        // Solicitar permisos para un conjunto de datos de HealthKit más amplio
        let healthDataTypes: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .heartRate)!,
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!,
            HKObjectType.quantityType(forIdentifier: .bodyMass)!,
            HKObjectType.quantityType(forIdentifier: .bodyFatPercentage)!,
            HKObjectType.quantityType(forIdentifier: .bodyMassIndex)!,
            HKObjectType.quantityType(forIdentifier: .restingHeartRate)!,
            HKObjectType.quantityType(forIdentifier: .walkingHeartRateAverage)!,
            HKObjectType.quantityType(forIdentifier: .oxygenSaturation)!,
            HKObjectType.quantityType(forIdentifier: .bloodPressureSystolic)!,
            HKObjectType.quantityType(forIdentifier: .bloodPressureDiastolic)!
        ]
        
        healthStore.requestAuthorization(toShare: nil, read: healthDataTypes) { success, error in
            DispatchQueue.main.async {
                self.checkAuthorization()
            }
        }
    }
}
