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
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
        displayTotalScore()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return quizAnswers.count+1
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
         if indexPath.row == 0{
             let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as! TitleTableViewCell
             cell.quizAnswers = quizAnswers
             cell.update = { [weak self] sortedArray in
                 self?.quizAnswers = sortedArray
                 tableView.reloadData()
             }
             return cell
             
         }else{
             let cell = tableView.dequeueReusableCell(withIdentifier: "QuizListCell", for: indexPath) as! QuizTabelViewCell
             let quizAnswer = quizAnswers[indexPath.row-1]
             cell.questionLabel.text = quizAnswer.question.getQuestionText()
             cell.answerLabel.text = quizAnswer.answer
             cell.isCorrectLabel.text = quizAnswer.isCorrect ? "Correct" : "Incorrect"
             return cell
         }
     }
 
     func displayTotalScore() {
         let totalQuestions = quizAnswers.count
         let correctAnswers = quizAnswers.filter({ $0.isCorrect }).count
         if totalQuestions == 0{
             scoreLabel.text = "  Total score:    0"
         }else{
             let score = (Double(correctAnswers)/Double(totalQuestions)) * 100
             scoreLabel.text = String(format: "  Total score: %.1f%%", score)
         }
     }
}

