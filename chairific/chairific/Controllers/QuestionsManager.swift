//
//  QuestionsManager.swift
//  chairific
//
//  Created by Ivan Semeniuk on 08/11/2024.
//

import Foundation
import SwiftUI


class QuestionsManager {
    static let shared = QuestionsManager()
    
    private init() {

    }
    
    func loadQuestionsFromJSON(isEmployee: Bool, completion: @escaping ([QuestionView]) -> Void) {
        if isEmployee {
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
        } else {
            if let url = Bundle.main.url(forResource: "employer_questions", withExtension: "json") {
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
}
