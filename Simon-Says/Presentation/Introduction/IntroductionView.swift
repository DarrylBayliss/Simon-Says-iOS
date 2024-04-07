//
//  ContentView.swift
//  Simon-Says
//
//  Created by Darryl Bayliss on 25/03/2024.
//

import SwiftUI

struct IntroductionView: View {
    
    var body: some View {
        NavigationStack() {
            VStack(spacing: 20) {
                Text("Welcome to Simon Says")
                
                NavigationLink("Play", value: SelectedButton.play)
                
                NavigationLink("Instructions", value: SelectedButton.instructions)
            }.navigationDestination(for: SelectedButton.self) { selectedButton in
                if (selectedButton == .play) {
                    PlayView()
                } else if (selectedButton == .instructions) {
                    InstructionsView()
                }
            }
                .navigationTitle("Simons Says")
        }
    }
}

#Preview {
    IntroductionView()
}

enum SelectedButton {
    case play
    case instructions
}
