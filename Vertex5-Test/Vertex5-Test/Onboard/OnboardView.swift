//
//  OnboardView.swift
//  Vertex5-Test
//
//  Created by Admin on 06/01/2024.
//

import SwiftUI

struct OnboardView: View {
    @State var steps: Int = 0
    private var totalSteps: Int = 2
    
    var body: some View {
        VStack {
            OnboardHeaderView(
                totalSteps: totalSteps,
                currentStep: steps,
                onBackTap: onPrevStep,
                onSkipTap: {
                    onNextStep(currentStepSelections: [])
                })
            .padding(.horizontal,20)
            
            TabView(selection: $steps) {
                OnboardHeightView(onContinue: { _heightSelection in
                    onNextStep(currentStepSelections: _heightSelection)
                })
                .tag(0)
                .padding(.horizontal,20)
                .padding(.top, 40)
                OnboardWeightView(onContinue: { _weightSelection in
                    onNextStep(currentStepSelections: _weightSelection)
                })
                .tag(1)
                .padding(.horizontal,20)
                .padding(.top, 40)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut)
            .transition(.slide)
        }
    }
    
    private func onNextStep(currentStepSelections: [String]) {
        print(currentStepSelections)
        guard steps < totalSteps - 1 else { return }
        steps += 1
    }
    
    private func onPrevStep() {
        guard steps > 0 else { return }
        steps -= 1
    }
}

#Preview {
    OnboardView()
}
