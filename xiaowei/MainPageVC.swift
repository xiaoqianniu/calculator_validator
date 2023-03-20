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
    
    var currentQuestion : Question?
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
    
    var quizQuestionsList = [(Question, String, Bool)]()
    @IBAction func generateButtonTapped(_ sender: Any) {
        answerTextField.text = ""
        quizCheckTitle.text = ""
        currentQuestion = Question()
        let questionText = currentQuestion?.generateQuestionText()
        operationLabel.text = questionText
        if !currentQuestion!.isValid() {
            answerTextField.text = "Divided by Zero"
        }
    }
   
    @IBAction func scoreButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let resultVC = storyboard.instantiateViewController(withIdentifier: "ResultVC") as! ResultVC
          resultVC.quizAnswers = quizQuestionsList
          present(resultVC, animated: true, completion: nil)
        
    }
    
    @IBAction func validateButtonTapped(_ sender: UIButton) {
        
        
        guard let userAnswer = Double(answerTextField.text ?? "")else {
            print("Invalid input")
            return
        }
            
            if let currentQuestion = currentQuestion {
                
                if (currentQuestion.isValid()){
                                
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
                    quizQuestionsList.append((currentQuestion,
                                              answerTextField.text ?? "",
                                              currentQuestion.isCorrectAnswer(userAnswer)))
                }
            } else {
                print("current QUESTION MISSING")
                return
            }
        
    }
        
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultVC = segue.destination as? ResultVC {
            resultVC.quizAnswers = quizQuestionsList
        }
    }
    
    func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}

