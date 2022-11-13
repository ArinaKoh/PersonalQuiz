//
//  ResultViewController.swift
//  PersonalQuiz
//
//  Created by Arina on 12.11.2022.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var definitionLabel: UILabel!
    
    var responses: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        calculateResult()
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        view.window?.rootViewController?.dismiss(animated: true)
        // navigationController?.dismiss(animated:true)
    }
    
    private func calculateResult() {
        var varietyOfAnswers: [Animal: Int] = [:]
        let responseTypes = responses.map{ $0.animal }
        
        for response in responseTypes {
            varietyOfAnswers[response] = (varietyOfAnswers[response] ?? 0) + 1
        }
        
       // let mostCommonAnswer =
        
      //  answerLabel.text = "Вы - \(mostCommonAnswer.rawValue)!"
      // definitionLabel.text = mostCommonAnswer.definition
        
    }
}
