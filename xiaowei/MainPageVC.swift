//
//  ViewController.swift
//  xiaowei
//
//  Created by Hongbo Niu on 2023-03-17.
//

import UIKit

class MainPageVC: UIViewController {

    @IBOutlet weak var quizCheckTitle: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var operationLabel: UILabel!
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet var numberButtons: [UIButton]!
    
    @IBOutlet weak var negativeButton: UIButton!
    @IBOutlet weak var dotButton: UIButton!
    @IBOutlet weak var validateButton: UIButton!
    @IBOutlet weak var generateButton: UIButton!
    let buttonData: [(String, Int)] = [("1", 1), ("2", 2), ("3", 3), ("4", 4), ("5", 5), ("6", 6), ("7", 7), ("8", 8), ("9", 9), ("0", 0)]
    
    var currentQuestion : QuestionAnswer?
    override func viewDidLoad() {
        super.viewDidLoad()
        for (index,button) in numberButtons.enumerated(){
            button.tag = buttonData[index].1
            button.setTitle(buttonData[index].0, for: .normal)
        }
        answerTextField.addTarget(self, action: #selector(answerEditingValidated), for: .editingChanged)
    }
    
    @IBAction func answerEditingValidated(_ sender: UITextField) {
  
  
    }
    
    @IBAction func negativeButtonTapped(_ sender: UIButton) {
        if let answer = answerTextField.text {
            if(answer.contains(".")){
                if let number = Double(answer) {
                    answerTextField.text = String(-number)
                }
                else
                {
                    answerTextField.text = "Invaid answer"
                }
            }
            else{
                if let number = Int(answer) {
                    answerTextField.text = String(-number)
                }
                else
                {
                    answerTextField.text = "Invaid answer"
                }
            }
        }
        print(answerTextField.text!)
    }
  
    @IBAction func dotButtonTapped(_ sender: Any) {
        if let answer = answerTextField.text {
            if(answer.isEmpty){
                answerTextField.text = "0"
            }
            let decimalSeparator = Locale.current.decimalSeparator ?? "."
            if !answer.contains(decimalSeparator){
                answerTextField.text = (answerTextField.text ?? "") + decimalSeparator
            }
        }
        
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        answerTextField.text = ""
        quizCheckTitle.text = ""
        operationLabel.text = ""

    }
    
    @IBAction func numberButtonsTapped(_ sender: UIButton) {
        guard let digit = sender.currentTitle else{
            return
        }
        answerTextField.text = (answerTextField.text ?? "") + digit
        print(answerTextField.text!)
    }
    
    
    @IBAction func generateButtonTapped(_ sender: Any) {
        answerTextField.text = ""
        quizCheckTitle.text = ""
        let question = QuestionAnswer.generateQuestion()
        switch question {
        case .success(let questionAnswer):
            currentQuestion = questionAnswer
            operationLabel.text = "\(questionAnswer.operand1) \(questionAnswer.operatorSymbol) \(questionAnswer.operand2)"
            validateButton.isEnabled = true
        case .failure(_):
            validateButton.isEnabled = false
        }
        
        
    }
   
    @IBAction func validateButtonTapped(_ sender: UIButton) {
        guard let userAnswer = Double(answerTextField.text ?? "") else {
            print("Invalid input")
                    return
                }
        
        guard let currentQuestion = currentQuestion else {
            print("current QUESTION MISSING")
            return
        }
        switch currentQuestion.validateAnswer(userAnswer) {
        case .success(let isCorrect):
            if isCorrect {
                quizCheckTitle.text = "Correct!"
                quizCheckTitle.textColor = UIColor.green
            } else {
                quizCheckTitle.text = "Incorrect"
                quizCheckTitle.textColor = UIColor.red
            }
        case .failure(let error):
            quizCheckTitle.text = "Error: " + error.localizedDescription
            quizCheckTitle.textColor = UIColor.red
        }
    }

}

