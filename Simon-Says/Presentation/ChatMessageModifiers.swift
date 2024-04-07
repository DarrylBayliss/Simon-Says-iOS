//
//  ChatMessageModifiers.swift
//  Simon-Says
//
//  Created by Darryl Bayliss on 01/04/2024.
//

import Foundation
import SwiftUI

struct SentMessage: ViewModifier {
    
    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(Color.blue)
            content
                .foregroundStyle(.white)
                .multilineTextAlignment(.leading)
                .padding()
                .frame(maxWidth: 200, alignment: .leading)
        }
        .padding(.trailing, 180)
    }
}

struct RecievedMessage: ViewModifier {
    
    func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            RoundedRectangle(cornerRadius: 10.0)
             .fill(Color.blue)
            content
                .foregroundStyle(.white)
                .multilineTextAlignment(.trailing)
                .padding()
                .frame(maxWidth: 200, alignment: .trailing)
        }
        .padding(.leading, 180)
    }
}

extension View {
    func sentMessageStyle() -> some View {
        modifier(SentMessage())
    }
    
    func recievedMessageStyle() -> some View {
        modifier(RecievedMessage())
    }
}
