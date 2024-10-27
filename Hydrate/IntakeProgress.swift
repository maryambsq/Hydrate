//
//  IntakeProgress.swift
//  Hydrate
//
//  Created by Maryam Amer Bin Siddique on 24/04/1446 AH.
//

import SwiftUI

struct IntakeProgress: View {
    let intake: Double
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 33)
                .frame(width: 300, height: 300)
                .foregroundColor(Color(red: 0.949, green: 0.949, blue: 0.971))
            Circle()
                .trim(from: 0, to: intake)
                .stroke(style: StrokeStyle(lineWidth: 33, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color(red: 0.192, green: 0.68, blue: 0.903))
                .frame(width: 300, height: 300)
                .rotationEffect(.degrees(-90))
                .animation(.linear)
        }
    }
}

struct UseIntakeProgress: View {
    @State var intake: Double = 0.0
    let waterIntakeGoal: Double

    var body: some View {
        VStack {
            Text("Today's Water Intake")
                .font(.body)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
            HStack(spacing: 0) {
                Text("\(String(format: "%.1f", intake)) liter")
                    .foregroundColor(intake >= waterIntakeGoal ? .green : .primary)
                Text(" / \(String(format: "%.1f", waterIntakeGoal)) liter")
                    .foregroundColor(.black)
            }
            .font(.title)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
            .padding(.bottom, 100)


            // frame(system(size:56))
            ZStack {
                Image(systemName: getIconName(for: intake / (waterIntakeGoal > 0 ? waterIntakeGoal : 1)))
                    .font(.system(size: 60))
                    .foregroundColor(Color(red: 1.0, green: 0.8, blue: 0.006))
                    .scaledToFit()
                
                IntakeProgress(intake: intake / (waterIntakeGoal > 0 ? waterIntakeGoal : 1))
            }
            
            Text("\(String(format: "%.1f", intake)) L")
                .padding(.top, 115)
                .font(.title)
                .fontWeight(.bold)

            Stepper(value: $intake, in: 0...waterIntakeGoal, step: 0.1) {

            }
            .padding(.trailing, 155)
            .navigationBarBackButtonHidden(true)
        }
        .onAppear {
            if waterIntakeGoal <= 0 {
                print("Goal must be greater than zero")
            }
        }
    }

    func getIconName(for progress: Double) -> String {
        switch progress {
        case 0:
            return "zzz"
        case 0.01...0.4:
            return "tortoise.fill"
        case 0.4...0.99:
            return "hare.fill"
        default:
            return "hands.clap.fill"
        }
    }
}

#Preview {
    UseIntakeProgress(waterIntakeGoal: 2.4)
}
