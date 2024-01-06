//
//  WeightView.swift
//  Vertex5-Test
//
//  Created by Admin on 06/01/2024.
//

import SwiftUI

struct OnboardWeightView: View {
    private let data: [[String]] = [
        Array(30...400).map { "\($0)" },
        ["."],
        Array(0...9).map { "\($0)" },
        ["kg", "lbs", "st/lbs"]
    ]
    
    @State private var selections: [String] = ["30", ".","0", "kg"]
    
    var onContinue: (_ selections: [String]) -> Void
    
    init(onContinue: @escaping ([String]) -> Void) {
        self.onContinue = onContinue
    }
    
    var body: some View {
        VStack {
            Text("What is your weight?")
                .font(.system(size: 24, weight: .bold))
            
            PickerView(data: data, selections: $selections)
                .frame(maxHeight: .infinity)
            
            Button(action: {
                onContinue(selections)
            }, label: {
                Text("Continue")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity)
            })
            .padding(10)
            .background(Color(hex: 0x1A1C21))
            .cornerRadius(8)
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    OnboardWeightView(onContinue: {_ in })
}
