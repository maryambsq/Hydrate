//
//  NotificationPreference.swift
//  Hydrate
//
//  Created by Maryam Amer Bin Siddique on 24/04/1446 AH.
//

import SwiftUI

struct NotificationPreference: View {
    @State private var startAM = "AM"
    @State private var endAM = "AM"
    @State private var startHour: Date = Date()
    @State private var endHour: Date = Date()
    @State private var selectedInterval: Int? = nil
    @State private var showStartTimePicker = false
    @State private var showEndTimePicker = false
    @State private var intakeGoal: Double = 2.4


    var body: some View {
        VStack {
            VStack {
                Text("Notification Preferences")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 20)
                Text("The Start and End Hour")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 1)
                Text("Specify the start and end date to receive notifications.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.top, -160)

            VStack {
                HStack {
                    Text("Start hour")
                        .padding(.trailing, 55)
                        .font(.callout)
                    Button("\(formattedTime(from: startHour))") {
                        showStartTimePicker.toggle()
                    }
                    .foregroundStyle(.black)
                    .padding(5)
                    .padding(.leading, 25)
                    .background(Color(red: 0.89, green: 0.89, blue: 0.912))
                    .cornerRadius(5)
                    .sheet(isPresented: $showStartTimePicker) {
                        VStack {
                            DatePicker("Select Start Time", selection: $startHour, displayedComponents: .hourAndMinute)
                                .datePickerStyle(WheelDatePickerStyle())
                                .labelsHidden()
                            Button("Done") {
                                showStartTimePicker = false
                            }
                            .foregroundColor(Color(red: 0.192, green: 0.68, blue: 0.903))
                            .padding()
                        }
                        .padding()
                    }

                    Picker("Select Time Period", selection: $startAM) {
                        Text("AM").tag("AM")
                        Text("PM").tag("PM")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.leading)
                    .padding(.trailing)
                    .frame(width: 120)

                }
                .padding(10)
                .padding(.bottom, -10)
                .frame(maxWidth: .infinity, alignment: .leading)

                Divider()
                    .frame(width: 350)

                HStack {
                    Text("End hour")
                        .padding(.trailing, 63)
                        .font(.callout)
                    Button("\(formattedTime(from: endHour))") {
                        showEndTimePicker.toggle()
                    }
                    .foregroundStyle(.black)
                    .padding(5)
                    .padding(.leading, 25)
                    .background(Color(red: 0.89, green: 0.89, blue: 0.912))
                    .cornerRadius(5)
                    .sheet(isPresented: $showEndTimePicker) {
                        VStack {
                            DatePicker("Select End Time", selection: $endHour, displayedComponents: .hourAndMinute)
                                .datePickerStyle(WheelDatePickerStyle())
                                .labelsHidden()
                            Button("Done") {
                                showEndTimePicker = false
                            }
                            .foregroundColor(Color(red: 0.192, green: 0.68, blue: 0.903))
                            .padding()
                        }
                        .padding()
                    }

                    Picker("Select Time Period", selection: $endAM) {
                        Text("AM").tag("AM")
                        Text("PM").tag("PM")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.leading)
                    .padding(.trailing)
                    .frame(width: 120)
                }
                .padding(10)
                .padding(.top, -10)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(Color(red: 0.949, green: 0.949, blue: 0.971))

            VStack {
                VStack {
                    Text("Notification Interval")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 1)

                    Text("How often would you like to receive notifications within the specified time interval")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    VStack {
                        IntervalRow(intervalType: "Mins", intervals: [15, 30, 60, 90], selected: $selectedInterval)
                        IntervalRow(intervalType: "Hours", intervals: [2, 3, 4, 5], selected: $selectedInterval)
                    }
                }
                NavigationLink(destination: UseIntakeProgress(waterIntakeGoal: intakeGoal)) {
                    Text("Start")
                        .padding()
                        .padding(.leading, 144)
                        .padding(.trailing, 144)
                        .background(Color(red: 0.192, green: 0.68, blue: 0.903))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.top, 65)
                }
            }
            .padding(.top, 30)
        }
        .padding()
        .padding(.bottom, -200)
        .padding(.top, -30)
        .navigationBarBackButtonHidden(true)
    }

    private func formattedTime(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm"
        return formatter.string(from: date)
    }
}

struct IntervalRow: View {
    let intervalType: String
    let intervals: [Int]
    @Binding var selected: Int?

    var body: some View {
        HStack {
            ForEach(intervals, id: \.self) { interval in
                IntervalButton(number: interval, unit: intervalType, isSelected: selected == interval) {
                    selected = interval
                }
                Spacer()
            }
        }
        .padding(.top)
    }
}

struct IntervalButton: View {
    let number: Int
    let unit: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                Text("\(number)")
                    .foregroundColor(isSelected ? .white : Color(red: 0.182, green: 0.68, blue: 0.899))
                Text(unit)
                    .foregroundColor(isSelected ? .white : .black)
            }
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(isSelected ? Color(red: 0.192, green: 0.68, blue: 0.903) : Color(red: 0.949, green: 0.949, blue: 0.975))
            .cornerRadius(10)
        }
    }
}

#Preview {
    NotificationPreference()
}
