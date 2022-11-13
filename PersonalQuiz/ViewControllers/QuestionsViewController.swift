//
//  ViewController.swift
//  PersonalQuiz
//
//  Created by Arina on 11.11.2022.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet var questionProgressView: UIProgressView!
    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet var secondaryStackView: UIStackView!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var multipleSwitches: [UISwitch]!
    
    @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet var rangedSlider: UISlider! {
        didSet {
            let answerCount = Float(currentAnswers.count - 1)
            rangedSlider.maximumValue = answerCount
            rangedSlider.value = answerCount / 2
        }
    }
    @IBOutlet var rangedLabels: [UILabel]!
    
    //MARK: - Private Properties
    private let questions = Question.getQuestion()
    private var questionIndex = 0
    private var answersChosen: [Answer] = []
    private var currentAnswers: [Answer] { questions[questionIndex].answers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "resultVC" {
                let resultViewController = segue.destination as! ResultViewController
                resultViewController.responses = answersChosen
            }
        }
    

    //MARK: - IBActions
    @IBAction func singleButtonPressed(_ sender: UIButton) {
        guard let buttonIndex = singleButtons.firstIndex(of: sender) else { return }
        let currentAnswer = currentAnswers[buttonIndex]
        answersChosen.append(currentAnswer)
        
        goToNextQuestion()
    }
    
    @IBAction func multipleButtonPressed() {
        for (multipleSwitch, answer) in zip(multipleSwitches, currentAnswers) {
            if multipleSwitch.isOn {
                answersChosen.append(answer)
            }
        }
        goToNextQuestion()
    }
    
    @IBAction func rangedButtonPressed() {
        let index = lrintf(rangedSlider.value)
        answersChosen.append(currentAnswers[index])
        
        goToNextQuestion()
    }
}

//MARK: - Navigation
extension QuestionsViewController {
    private func goToNextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
            return
        }
        
        performSegue(withIdentifier: "resultVC", sender: nil)
    }
}

//MARK: - Extension
extension QuestionsViewController {
    
    private func updateUI() {
        for stackView in [singleStackView, secondaryStackView, rangedStackView] {
            stackView?.isHidden = true
        }
        //Get current question
        let currenQuestion = questions[questionIndex]
        
        //set current question for question Label
        questionLabel.text = currenQuestion.title
        
        // calculate progress
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        //set progress for questionProgressView
        questionProgressView.setProgress(totalProgress, animated: true)
        
        //set navigation title
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        
        //Show stacks corresponding to question type
        showCurrentAnswers(for: currenQuestion.responseType)
    }
    
    private func showCurrentAnswers(for type: ResponseType) {
        switch type {
        case .single: showSingleStack(with: currentAnswers)
            
        case .multiple: showMultipleStack(with: currentAnswers)
            
        case .ranged: showRangedStack(with: currentAnswers)
        }
    }
    
    private func showSingleStack(with answers: [Answer]) {
        singleStackView.isHidden = false
        
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.title, for: .normal)
        }
    }
    
    private func showMultipleStack(with answers: [Answer]) {
        secondaryStackView.isHidden = false
        
        for (label, answers) in zip(multipleLabels, answers) {
            label.text = answers.title
        }
    }
    
    private func showRangedStack(with answers: [Answer]) {
        rangedStackView.isHidden = false
        
        rangedLabels.first?.text = answers.first?.title
        rangedLabels.last?.text = answers.last?.title
    }
    
}
