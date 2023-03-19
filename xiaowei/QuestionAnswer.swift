//
//  QuestionAnswer.swift
//  xiaowei
//
//  Created by Hongbo Niu on 2023-03-18.
//

import Foundation
struct QuestionAnswer {
    var operand1: Double
    var operand2: Double
    var operatorSymbol: String
    var correctAnswer: Double
    var didEnterNumber: Bool = false
    
    init(operand1: Double, operand2: Double, operatorSymbol: String, correctAnswer: Double) {
        self.operand1 = operand1
        self.operand2 = operand2
        self.operatorSymbol = operatorSymbol
        self.correctAnswer = correctAnswer
    }
    
    enum QuestionError: Error {
        case invalidInput
        case multipleDecimalPoints
        case negativeSignInMiddle
        case divideByZero
        case invalidOperator
    }
    
    func generateQuestion() -> Result<QuestionAnswer, Error>{
        let num1 = Int.random(in: 0...10)
        let num2 = Int.random(in: 0...10)
        let operators = ["+", "-", "*", "/"]
        let op = operators.randomElement()!
        var answer: Double = 0.0
        var question = ""
        
        switch op {
        case "+":
            answer = Double(num1 + num2)
            question = "\(num1) + \(num2)"
        case "-":
            answer = Double(num1 - num2)
            question = "\(num1) - \(num2)"
        case "*":
            answer = Double(num1 * num2)
            question = "\(num1) * \(num2)"
        case "/":
            if num2 == 0 {
                
                return .failure(QuestionError.divideByZero)
            } else {
                answer = Double(num1 / num2)
                question = "\(num1) / \(num2)"
            }
        default:
            return.failure(QuestionError.invalidOperator)
    
        }
        let questionAnswer = QuestionAnswer(operand1: Double(num1), operand2: Double(num2), operatorSymbol: op, correctAnswer: answer)
        return .success(questionAnswer)
    }



     func calculateAnswer(operand1: Double, operand2: Double, operatorSymbol: String) -> Double {
        
         switch operatorSymbol {
         case "+":
             return operand1 + operand2
         case "-":
             return operand1 - operand2
         case "*":
             return operand1 * operand2
         case "/":
             return operand1 / operand2
         default:
             return 0
         }
     }
    func validateAnswer(_ userAnswer: Double) -> Result<Bool,Error> {
        if userAnswer.isNaN || userAnswer.isInfinite {
            return .failure(QuestionError.invalidInput)
        }
        
        let operand1String = String(operand1)
        let operand2String = String(operand2)
        
        if operand1String.contains("..") || operand2String.contains("..") {
            return .failure(QuestionError.multipleDecimalPoints)
        }
        
        if operand1String.count > 1 && operand1String.first == "-" && operand1String.dropFirst().contains(where: { $0.isNumber }) {
            return .failure(QuestionError.negativeSignInMiddle)
        }
        
        if operand2String.count > 1 && operand2String.first == "-" && operand2String.dropFirst().contains(where: { $0.isNumber }) {
            return .failure(QuestionError.negativeSignInMiddle)
        }
        
        if operatorSymbol == "/" && operand2 == 0 {
            return .failure(QuestionError.divideByZero)
        }
        
        return .success(userAnswer == correctAnswer)
    }



    func isCorrectAnswer(_ answer: Double) -> Bool {
          return answer == correctAnswer
      }
}
