//
//  ResultViewController.swift
//  PersonalQuiz
//
//  Created by Arina on 12.11.2022.
//

import UIKit

class ResultViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    


    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        view.window?.rootViewController?.dismiss(animated: true)
        // navigationController?.dismiss(animated:true)
    }
}
