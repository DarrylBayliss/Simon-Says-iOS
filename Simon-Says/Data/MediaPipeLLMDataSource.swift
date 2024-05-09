//
//  MediaPipeLLMDataSource.swift
//  Simon-Says
//
//  Created by Darryl Bayliss on 06/04/2024.
//

import Foundation
import MediaPipeTasksGenAI
import Factory

private let SimonSaysPrompt = """
    You are Simon in a game of Simon Says.
        
    For every task you give, you must prefix it with the words "Simon says".
        
    You must not ask the player to do anything that is dangerous, unethical or unlawful.
"""

private let DoTenPushUpsPrompt = SimonSaysPrompt + """

   Ask the player to do ten pushups.
"""

private let TouchHeadPrompt = SimonSaysPrompt + """

    Ask the player to touch their head.
"""

private let SingASongPrompt = SimonSaysPrompt + """

    Ask the player to sing their favourite song.
"""

private let TakePhotoOfOrangePrompt = SimonSaysPrompt + """

    Ask the player to take a photo of an orange.
"""

private let MakeANoisePrompt = SimonSaysPrompt + """

    Ask the player to make a loud noise.
"""


class MediaPipeLLMDataSource {
    
    private let prompts = [
            DoTenPushUpsPrompt,
            TouchHeadPrompt,
            SingASongPrompt,
            TakePhotoOfOrangePrompt,
            MakeANoisePrompt
        ]
    
    let llmInference = Container.shared.llmInference.callAsFunction()
    
    let logger = Container.shared.logger.callAsFunction()
    
    func start() async -> String {
        let prompt = prompts.randomElement()!
        logger.debug("Starting Simon says with the following prompt: \(prompt)")
        var message: String = ""
        
        do {
            message = try llmInference.generateResponse(inputText: prompt)
        } catch {
            if (error is GenAiInferenceError) {
                message = error.localizedDescription
            }
        }
        
        logger.debug("Recieved simon says task from starting method: \(message)")
        return message
    }
    
    func sendMessage() async -> String  {
        let prompt = prompts.randomElement()!
        logger.debug("Passing LLM the following prompt: \(prompt)")
        var message: String = ""
    
        do {
            message = try llmInference.generateResponse(inputText: prompt)
        } catch {
            if (error is GenAiInferenceError) {
                message = error.localizedDescription
            }
        }
        
        logger.debug("Recieved simon says task from starting method: \(message)")
        return message
    }
}
