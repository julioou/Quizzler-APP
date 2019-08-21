//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import ProgressHUD

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank()
    var pickedAnswer: Bool = false
    var questionNumber: Int = 0
    var score = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let firstQuestion = allQuestions.list[0]
//        questionLabel.text = firstQuestion.questionText
        questionLabel.text = allQuestions.list[0].questionText
        updateUI()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        
        if sender.tag == 1 {
            pickedAnswer = true
        }
        else if sender.tag == 2 {
            pickedAnswer = false
        }
        checkAnswer()
        
        questionNumber = questionNumber + 1
        
        nextQuestion()
        
        updateUI()
    }
    
    
    func updateUI() {
        
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber + 1)
        progressLabel.text = "\(String(questionNumber + 1))/\(allQuestions.list.count)"
        scoreLabel.text = "Score: \(score)"
    }
    

    func nextQuestion() {
        
        questionLabel.text = allQuestions.list[questionNumber].questionText
        
        if questionNumber >= 12 {
            
            let alert = UIAlertController(title: "Awesome", message: "You finish the questions.", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: {
                (UIAlertAction) in
                self.startOver()
            })
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func checkAnswer() {
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        if correctAnswer == pickedAnswer {
            print("You got it!")
            let randomScore = Int.random(in: 300 ... 358)
            score = score + randomScore
            ProgressHUD.showSuccess("Correct!")
        }
        else {
            print("Wrong!")
            ProgressHUD.showError("Wrong!")
        }
    }
    
    
    func startOver() {
        score = 0
        progressBar.frame.size.width = (view.frame.size.width / 13)
        questionNumber = 0
        nextQuestion()
        updateUI()
    }

}
