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
    var resultsTableView: UITableView?
  
    override func awakeFromNib() {
        super.awakeFromNib()

        let menuClosure = {(action: UIAction) in
            
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
        
        var quizAnswers = [Question]() {
            didSet {
                sortQuizAnswers()
            }
        }
    func sortQuizAnswers() {
        if (sortAscending && quizAnswers == quizAnswers.sorted(by: {$0.isCorrect && !$1.isCorrect})) ||
              (!sortAscending && quizAnswers == quizAnswers.sorted(by: {!$0.isCorrect && $1.isCorrect})) {
              return
          }
        if sortAscending {
            print("ascending")
            quizAnswers = quizAnswers.sorted(by: {$0.isCorrect && !$1.isCorrect})
        } else {
            print("descending")
            quizAnswers = quizAnswers.sorted(by: {!$0.isCorrect && $1.isCorrect})
        }
         resultsTableView?.reloadData()
    }
        
    
}
