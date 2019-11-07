//
//  ContentView.swift
//  WeSplit
//
//  Created by Walter Oliveira on 07/11/19.
//  Copyright © 2019 Walter Oliveira. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputNumber = ""
    @State private var inputUnit = 1
    @State private var outputUnit = 1
    
    let units = ["Celsius", "Kelvin", "Fahrenheit"]
    
    var outputNumber: Double {
        
        let inputValue = Double(inputNumber) ?? nil
        
        if inputValue == nil {
            return 0
        }
        return convertFromCelsius(convertToCelsius(inputValue ?? 0, source: inputUnit), target: outputUnit)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("Convert from:")){
                    Picker("From:", selection: $inputUnit) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Convert to:")) {
                    
                    Picker("To:", selection: $outputUnit) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Enter value:")) {
                    TextField("", text: $inputNumber)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Converted value:")) {
                    Text("\(outputNumber, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("Converter", displayMode: .inline)
        }
    }
    
    func convertToCelsius(_ t: Double, source: Int) -> Double {
        switch source {
        case 0:
            return t
        case 1:
            return t - 273.15
        case 2:
            return (t - 32) * 5 / 9
        default:
            return 0
        }
    }
    
    func convertFromCelsius(_ t: Double, target: Int) -> Double {
        switch target {
        case 0:
            return t
        case 1:
            return t + 273.15
        case 2:
            return t * 9 / 5 + 32
        default:
            return 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
