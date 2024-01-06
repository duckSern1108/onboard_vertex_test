//
//  OnboardHeaderView.swift
//  Vertex5-Test
//
//  Created by Admin on 06/01/2024.
//

import SwiftUI

struct OnboardHeaderView: View {
    var totalSteps: Int
    var currentStep: Int
    
    var onBackTap: () -> Void
    var onSkipTap: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                onBackTap()
            }, label: {
                Image("ArrowLeft", bundle: nil)
            })
            .opacity(currentStep > 0 ? 1 : 0)
            
            HStack(spacing: 8) {
                ForEach(0..<totalSteps, id: \.self) { _step in
                    Rectangle()
                        .fill(_step <= currentStep ? Color(hex: 0x1A1C21) : Color(hex: 0x1A1C21, alpha: 0.1))
                        .frame(width: 44, height: 4)
                        .cornerRadius(2)
                }
            }
            .frame(maxWidth: .infinity)
            
            Button(action: {
                onSkipTap()
            }, label: {
                Text("Skip")
                    .foregroundColor(Color(hex: 0x98A2B3))
            })
            .opacity(currentStep < totalSteps - 1 ? 1 : 0)
        }
    }
}

#Preview {
    OnboardHeaderView(totalSteps: 4, currentStep: 3, onBackTap: {}, onSkipTap: {})
}
