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
        ScrollViewReader { scrollProxy in
            ScrollView {
                VStack {
                    ForEach(viewModel.messages) { message in
                        if (message.isFromUser) {
                            Text(message.text)
                                .sentMessageStyle()
                                .id(message.id)
                            
                        } else {
                            Text(message.text)
                                .recievedMessageStyle()
                                .id(message.id)
                        }
                    }
                }.onChange(of: viewModel.messages, initial: false, {
                    scrollProxy.scrollTo(viewModel.messages.last?.id)
                })
                .padding(.trailing, 10)
                .padding(.leading, 10)
            }
            .safeAreaInset(edge: .bottom) {
                ChatBox(onSendMessage: { message in
                    Task { await viewModel.sendMessage(userMessage: message) }
                })
            }.task {
                await viewModel.startGame()
            }
        }
    }
}

struct ChatBox: View {
    
    @State var message: String = ""
    
    @FocusState private var messageIsFocused: Bool
    
    var onSendMessage: (String) -> Void
    
    var body: some View {
        HStack {
            TextField("", text: $message)
                .padding(.leading)
                .focused($messageIsFocused)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("", systemImage: "paperplane", action: {
                onSendMessage(message)
            })
        }
    }
}

#Preview {
    return ChatBox(onSendMessage: { message in
        
    })
}
