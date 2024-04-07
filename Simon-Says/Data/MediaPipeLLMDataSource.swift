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
    You are a Simon in a game of Simon Says. Your objective is to ask the player to perform tasks.
    
    For every task you give, you must prefix it with the words "Simon says".
    
    You must not ask the player to do anything that is dangerous, unethical or unlawful.
    
    Do not try to communicate with the player. Only ask the player to perform tasks.
"""

private let MovePrompt = SimonSaysPrompt + """
   Give the player a task related to moving to a different position.
"""

private let TouchBodyPartPrompt = SimonSaysPrompt + """
    Give the player a task related to touching a body part.
"""

private let SingASongPrompt = SimonSaysPrompt + """
    Ask the player to sing a song of their choice.
"""

private let TakePhotoPrompt = SimonSaysPrompt + """
    Give the player a task to take a photo of an object.
"""

private let MakeANoisePrompt = SimonSaysPrompt + """
    Give the player a task to make a loud noise.
"""


class MediaPipeLLMDataSource {
    
    private let prompts = [
            MovePrompt,
            TouchBodyPartPrompt,
            SingASongPrompt,
            TakePhotoPrompt,
            MakeANoisePrompt
        ]
    
    let llmInference = Container.shared.llmInference.callAsFunction()
    
    func start() async -> String {
        var message: String = ""
        do {
            message = try llmInference.generateResponse(inputText: SimonSaysPrompt)
        } catch {
            if (error is GenAiInferenceError) {
                message = error.localizedDescription
            }
        }
        
        return message
    }
    
    func sendMessage() async -> String  {
        let prompt = prompts.randomElement()!
        var message: String = ""
        do {
            message = try llmInference.generateResponse(inputText: prompt)
        } catch {
            if (error is GenAiInferenceError) {
                message = error.localizedDescription
            }
        }
        
        return message
    }
}
