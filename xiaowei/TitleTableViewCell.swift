//
//  TitleTableViewCell.swift
//  xiaowei
//
//  Created by Hongbo Niu on 2023-03-20.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sortButton: UIButton!
    var sortAscending = true
    var update: (([(question: Question, answer: String, isCorrect: Bool)]) -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let menuClosure = { [self](action: UIAction) in
            self.update(number: action.title)
            if action.title == "sort" {
                 print("sort selected")
             } else if action.title == "Ascending" {
                 self.sortAscending = true
                 self.sortQuizAnswers()
             } else if action.title == "Descending" {
                 self.sortAscending = false
                 self.sortQuizAnswers()
             }
        }
        
        sortButton.menu = UIMenu(children: [
            UIAction(title: "sort", state: .on, handler:
                        menuClosure),
            UIAction(title: "Ascending", handler: menuClosure),
            UIAction(title: "Descending", handler: menuClosure),
        ])
        sortButton.showsMenuAsPrimaryAction = true
        sortButton.changesSelectionAsPrimaryAction = true
    }
    func update(number:String) {
        if number == "sort" {
            print("sort selected")
        }
    }
  
  @IBAction func sortButtonSelected(_ sender: UIButton) {
        }
    
    var quizAnswers = [(question: Question, answer: String, isCorrect: Bool)]()

    func sortQuizAnswers() {
        var sortedArray = [(question: Question, answer: String, isCorrect: Bool)]()
        if sortAscending {
            sortedArray = quizAnswers.sorted(by: {$0.isCorrect && !$1.isCorrect})
        } else {
            sortedArray = quizAnswers.sorted(by: {!$0.isCorrect && $1.isCorrect})
        }
        quizAnswers = sortedArray
        update?(quizAnswers)
    }
}
