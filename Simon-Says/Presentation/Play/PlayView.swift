//
//  PlayView.swift
//  Simon-Says
//
//  Created by Darryl Bayliss on 26/03/2024.
//

import SwiftUI
import Factory

struct PlayView: View {
    
    @State private var viewModel = Container.shared.playViewModel.callAsFunction()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.messages) { message in
                    if (message.isFromUser) {
                        Text(message.text)
                            .sentMessageStyle()
                            
                    } else {
                        Text(message.text)
                            .recievedMessageStyle()
                    }
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            ChatBox(onSendMessage: { message in
                Task { await viewModel.sendMessage(userMessage: message) }
            }, onTakePicture: {
                
            })
        }.task {
            await viewModel.startGame()
        }
    }
}

struct ChatBox: View {
    
    @State var message: String = ""
    
    @FocusState private var messageIsFocused: Bool
    
    var onSendMessage: (String) -> Void
    
    var onTakePicture: () -> Void
    
    var body: some View {
        HStack {
            TextField("", text: $message)
                .padding(.leading)
                .focused($messageIsFocused)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("", systemImage: "paperplane", action: {
                onSendMessage(message)
            })
            
            Button("", systemImage: "camera", action:  {
                onTakePicture()
            })
        }
    }
}

#Preview {
    return ChatBox(onSendMessage: { message in
        
    }, onTakePicture: {
        
    })
}
