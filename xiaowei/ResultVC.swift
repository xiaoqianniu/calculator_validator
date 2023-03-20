//
//  ResultVC.swift
//  xiaowei
//
//  Created by Hongbo Niu on 2023-03-18.
//

import UIKit

class ResultVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

  
    
    @IBOutlet weak var resultsTableView: UITableView!
    
    @IBOutlet weak var registerTextField: UITextField!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    var quizAnswers = [(question: Question, answer: String, isCorrect: Bool)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(quizAnswers)
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
//        quizAnswers = quizAnswers.map { (question: $0.question, answer: $0.answer, isCorrect: false) }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return quizAnswers.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "QuizListCell", for: indexPath) as! QuizTabelViewCell
         let quizAnswer = quizAnswers[indexPath.row]
         cell.questionLabel.text = quizAnswer.question.getQuestionText()
         cell.answerLabel.text = quizAnswer.answer
         cell.isCorrectLabel.text = quizAnswer.isCorrect ? "Correct" : "Incorrect"
         return cell
     }
     
     // Calculate and display total score
     func displayTotalScore() {
         let totalQuestions = quizAnswers.count
         let correctAnswers = quizAnswers.filter({ $0.isCorrect }).count
         let score = correctAnswers / totalQuestions * 100
         print("Total score: \(score)%")
     }


}
