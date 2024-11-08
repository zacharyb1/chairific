//
//  QuestionsManager.swift
//  chairific
//
//  Created by Benoit Pennaneach on 8.11.2024.
//

import Foundation
import SwiftUI


class QuestionsManager {
    static let shared = QuestionsManager()
    
    private init() {

    }
    
    func loadQuestionsFromJSON(completion: @escaping ([QuestionView]) -> Void) {
        if let url = Bundle.main.url(forResource: "employee_questions", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decodedQuestions = try JSONDecoder().decode([QuestionnaireQuestion].self, from: data)
                let questions = decodedQuestions.map { question in
                    QuestionView(
                        id: question.id,
                        question: question.question,
                        options: question.answers,
                        isCompleted: Binding.constant(false),
                        selectedAnswerIndex: Binding.constant(nil)
                    )
                }
                completion(questions)
            } catch {
                print("Failed to load or decode questions: \(error)")
            }
        } else {
            print("JSON file not found.")
        }
    }

}
