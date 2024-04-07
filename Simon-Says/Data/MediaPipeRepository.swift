//
//  MediaPipeDataFetcher.swift
//  Simon-Says
//
//  Created by Darryl Bayliss on 06/04/2024.
//

import Foundation
import Factory

class MediaPipeRepository {

    let mediaPipeLLMDataSource = Container.shared.mediaPipeLLMDataSource.callAsFunction()
        
    func start() async -> String {
        return await mediaPipeLLMDataSource.start()
    }
    
    func sendMessage() async -> String  {
        return await mediaPipeLLMDataSource.sendMessage()
    }
}
