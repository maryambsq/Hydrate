//
//  MainView.swift
//  Hydrate
//
//  Created by Maryam Amer Bin Siddique on 24/04/1446 AH.
//

import SwiftUI

struct MainView: View {
    @State private var bodyWeight: String = ""
    @State private var waterIntakeGoal: Double = 0.0
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Image(systemName: "drop.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height:  70)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(Color(red: 0.192, green: 0.68, blue: 0.903))
                        .padding(1)
                    
                    Text("Hydrate")
                        .font(.title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(3)
                    
                    Text("Start with Hydrate to record and track your water intake daily based on your needs and stay hydrated.")
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundColor(Color(red: 0.388, green: 0.388, blue: 0.401))
                        .padding(5)
                        .padding(.leading, -5)
                    
                    HStack {
                        Text("Body Weight")
                            .padding(15)
                            .padding(.leading, 5)
                        
                        TextField("Value", text: $bodyWeight)
                            .keyboardType(.decimalPad)
                            .padding(2)
                        
                        // Clear Button for Body Weight Field
                        if !bodyWeight.isEmpty {
                            Button(action: {
                                bodyWeight = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                            .padding(.trailing, 20)
                        }
                    }
                    .background(Color(red: 0.949, green: 0.949, blue: 0.971))
                    .foregroundColor(.black)
                    .frame(width: 370)
                    .padding(.top, 20)
                }
                .padding(.top, 140)
                
                Spacer()
                
                NavigationLink(destination: NotificationPreference()) {
                    Text("Next")
                        .padding()
                        .padding(.leading, 144)
                        .padding(.trailing, 144)
                        .background(bodyWeight.isEmpty ? Color.gray : Color(red: 0.192, green: 0.68, blue: 0.903))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(bodyWeight.isEmpty)
                .onChange(of: bodyWeight) { newValue in

                    if let weight = Double(newValue) {
                        waterIntakeGoal = weight * 0.03
                    } else {
                        waterIntakeGoal = 0.0
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    MainView()
}
