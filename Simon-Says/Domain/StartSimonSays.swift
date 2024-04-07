//
//  StartSimonSays.swift
//  Simon-Says
//
//  Created by Darryl Bayliss on 06/04/2024.
//

import Foundation
import Factory

class StartSimonSays {
    
    let mediaPipeRepository = Container.shared.mediaPipeRepository.callAsFunction()
    
    func invoke() async -> Message {
        let message = await mediaPipeRepository.start()
        return Message(text: message, image: nil, isFromUser: false)
    }
}
