//
//  PlayViewModel.swift
//  Simon-Says
//
//  Created by Darryl Bayliss on 06/04/2024.
//

import Foundation
import SwiftUI
import Factory


@Observable
class PlayViewModel {
    
    var messages: [Message] = []
    
    let startSimonSays = Container.shared.startSimonSays.callAsFunction()
    
    let sendMessageToSimon = Container.shared.sendMessageToSimon.callAsFunction()
    
    func startGame() async {
        messages += [awaitingMessageFromSimon]
        
        let message = await StartSimonSays().invoke()
        
        messages.removeLast()
        messages.append(message)
    }
    
    func sendMessage(userMessage: String) async {
        let newMessage = Message(text: userMessage, image: nil, isFromUser: true)
        messages += [newMessage, awaitingMessageFromSimon]
        
        let message = await SendMessageToSimon().invoke()
        
        messages.removeLast()
        messages.append(message)
        
    }
}

struct Message : Identifiable, Hashable {
    
    let id: UUID = UUID()
    private var _text: String = ""
    var text: String {
            get {
                return _text
            }
            set {
                self._text = newValue
            }
        }
    let image: Image?
    let isFromUser: Bool
    
    init(text: String, image: Image?, isFromUser: Bool) {
        self._text = text
        self.image = image
        self.isFromUser = isFromUser
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

private let awaitingMessageFromSimon = Message(
    text: "...",
    image: nil,
    isFromUser: false
)
