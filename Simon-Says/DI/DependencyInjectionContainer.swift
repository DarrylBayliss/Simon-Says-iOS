//
//  DependencyInjection.swift
//  Simon-Says
//
//  Created by Darryl Bayliss on 06/04/2024.
//

import Foundation
import Factory
import MediaPipeTasksGenAI

extension Container {
    var playViewModel: Factory<PlayViewModel> {
        self { PlayViewModel() }
    }
    
    var startSimonSays: Factory<StartSimonSays> {
        self { StartSimonSays() }
    }
    
    var sendMessageToSimon: Factory<SendMessageToSimon> {
        self { SendMessageToSimon() }
    }
    
    var mediaPipeRepository: Factory<MediaPipeRepository> {
        self { MediaPipeRepository() }
    }
    
    var mediaPipeLLMDataSource: Factory<MediaPipeLLMDataSource> {
        self { MediaPipeLLMDataSource() }
    }
    
    var llmInference: Factory<LlmInference> {
        self { LlmInference(modelPath: Bundle.main.path(forResource: "gemma-2b-it-cpu-int8", ofType: "bin")!) }
    }
}
