//
//  TimeAndDaysPicker.swift
//  RadioApp
//
//  Created by Келлер Дмитрий on 07.08.2024.
//

import SwiftUI

struct TimeAndDaysPicker: View {
    // MARK: - Properties
    @State private var selectedTime = Date()
    @State private var selectedDays = Set<String>()
    private let daysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    // MARK: - Body
    var body: some View {
        VStack {
            // MARK: - Time Picker
            DatePicker(Resources.Text.selectTime.localized(LocalizationService.shared.language), selection: $selectedTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(GraphicalDatePickerStyle())
                .labelsHidden()
                .padding()
            
            // MARK: - Days Picker
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Button(action: {
                        if selectedDays.contains(day) {
                            selectedDays.remove(day)
                        } else {
                            selectedDays.insert(day)
                        }
                    }) {
                        Text(day)
//                            .padding()
                            .background(selectedDays.contains(day) ? Color.blue : Color.gray)
                            .cornerRadius(8)
                            .foregroundColor(.white)
                    }
                }
            }
            .padding()
        }
    }
}
