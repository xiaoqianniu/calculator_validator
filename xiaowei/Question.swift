//
//  QuestionAnswer.swift
//  xiaowei
//
//  Created by Hongbo Niu on 2023-03-18.
//

import Foundation
struct Question {
    var operand1: Double
    var operand2: Double
    var operatorSymbol: String
    var isValidQuestion: Bool
    var questionText:String = ""
    var correctAnswer: Double
    
    init() {
        self.operand1 = 0
        self.operand2 = 0
        self.operatorSymbol = ""
        self.correctAnswer = 0
        self.isValidQuestion = false
    }
    
    func isValid() -> Bool{
        return isValidQuestion
    }
    
    enum QuestionError: Error {
        case invalidInput
        case multipleDecimalPoints
        case negativeSignInMiddle
        case divideByZero
        case invalidOperator
    }
    
    func getQuestionText() -> String{
        return questionText;
    }
    
    mutating func generateQuestionText() -> String{
        let num1 = Int.random(in: 0...10)
        operand1 = Double(num1)
        let num2 = Int.random(in: 0...10)
        operand2 = Double(num2)
        let operators = ["+", "-", "*", "/"]
        let op = operators.randomElement()!
        operatorSymbol = op
        isValidQuestion = true
        
        switch op {
        case "+":
            questionText = "\(num1) + \(num2)"
            correctAnswer = operand1 + operand2;
            break
        case "-":
            questionText = "\(num1) - \(num2)"
            correctAnswer = operand1 - operand2
            break
        case "*":
            questionText = "\(num1) * \(num2)"
            correctAnswer = operand1 * operand2
            break
        case "/":
            questionText = "\(num1) / \(num2)"
            if (num2 == 0){
                isValidQuestion = false
            }
            if(isValidQuestion == true){
                correctAnswer = operand1/operand2
            }
                
        default:
            //return.failure(QuestionError.invalidOperator)
            return questionText
        }
        return questionText
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
//
//        let operand1String = String(operand1)
//        let operand2String = String(operand2)
//
//        if operand1String.contains("..") || operand2String.contains("..") {
//            return .failure(QuestionError.multipleDecimalPoints)
//        }
//
//        if operand1String.count > 1 && operand1String.first == "-" && operand1String.dropFirst().contains(where: { $0.isNumber }) {
//            return .failure(QuestionError.negativeSignInMiddle)
//        }
//
//        if operand2String.count > 1 && operand2String.first == "-" && operand2String.dropFirst().contains(where: { $0.isNumber }) {
//            return .failure(QuestionError.negativeSignInMiddle)
//        }
//

        if(isValidQuestion == true)
        {
            return .success(userAnswer == correctAnswer)
        }
        
        if operatorSymbol == "/" && operand2 == 0 {
                    return .failure(QuestionError.divideByZero)
        }
        else{
            return .failure(QuestionError.invalidInput)
        }
    }



    func isCorrectAnswer(_ answer: Double) -> Bool {
          return answer == correctAnswer
      }
}
