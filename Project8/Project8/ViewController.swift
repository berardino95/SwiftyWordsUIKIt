//
//  ViewController.swift
//  Project8
//
//  Created by Berardino Chiarello on 04/09/23.
//

import UIKit

class ViewController: UIViewController {
    //create the variable that contain our view
    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    var currentAnswer: UITextField!
    var scoreLabel: UILabel!
    var letterButtons = [UIButton]()
    var levelLabel : UILabel!
    
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var level = 1 {
       didSet {
           levelLabel.text = "Level: \(level)"
       }
   }
    
    override func loadView() {
        //Assigning to the ViewController view a new UIView() and set its background to white
        view = UIView()
        view.backgroundColor = .white
        
        //Creating the scoreLabel and adding it to the view
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: \(score)"
        view.addSubview(scoreLabel)
        
        levelLabel = UILabel()
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.textAlignment = .left
        levelLabel.text = "Level: \(level)"
        view.addSubview(levelLabel)
        
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.text = "Clues"
        cluesLabel.numberOfLines = 0
        //Decide the priority of stretching or not this view, 1 is the lowest so UIKit will stretch this view
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(cluesLabel)
        
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.text = "Answers"
        answersLabel.textAlignment = .right
        answersLabel.numberOfLines = 0
        //Decide the priority of stretching or not this view, 1 is the lowest so UIKit will stretch this view
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(answersLabel)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap to letter to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("Submit", for: .normal)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(submit)
        
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("Clear", for: .normal)
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        view.addSubview(clear)
        
        //Create a view that contains all the buttons
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        //Set and activate the constraints
        NSLayoutConstraint.activate([
            
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            levelLabel.centerYAnchor.constraint(equalTo: scoreLabel.centerYAnchor),
            levelLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
            
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
            answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
            
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
            
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            submit.heightAnchor.constraint(equalToConstant: 44),
            
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
            clear.heightAnchor.constraint(equalTo: submit.heightAnchor),
            
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor,constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
            
        ])
        
        //Create the buttons with a loop
        let width = 150
        let height = 80
        
        for row in 0..<4 {
            for column in 0..<5 {
                //Create a Button
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                letterButton.setTitle("WWW", for: .normal)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                
                let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                
                //Add the button in the buttonsView
                buttonsView.addSubview(letterButton)
                //Add the button in the array of buttons
                letterButtons.append(letterButton)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadLevel()
    }
    
    
    @objc func letterTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
        activatedButtons.append(sender)
        sender.isHidden = true
    }
    
    @objc func submitTapped(_ sender: UIButton) {
        guard let answerText = currentAnswer.text else { return }
        
        //if the entered text is valid and match some solution
        if let solutionPosition = solutions.firstIndex(of: answerText){
            //Reset all the button clicked
            activatedButtons.removeAll()
            
            //Create an array from the String answers
            var splitAnswer = answersLabel.text?.components(separatedBy: "\n")
            //changing the hint (7 letters) with the correct word
            splitAnswer?[solutionPosition] = answerText
            //Join the array into a string and assign it to the answersLabel
            answersLabel.text = splitAnswer?.joined(separator: "\n")
            
            currentAnswer.text = ""
            score += 1
            
            if score % 7 == 0 {
                let ac = UIAlertController(title: "Well done", message: "You entered all the answer", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Next Level", style: .default, handler: levelUp))
                present(ac, animated: true)
            }
        }
    }
    
    @objc func clearTapped(_ sender: UIButton) {
        currentAnswer.text = ""
        
        //reactivating the buttons
        for button in activatedButtons {
            button.isHidden = false
        }
        
        activatedButtons.removeAll()
    }
    
    func levelUp(action: UIAlertAction){
        level += 1
        solutions.removeAll(keepingCapacity: true)
        
        loadLevel()
        
        for button in letterButtons {
            button.isHidden = false
        }
    }
    
    func loadLevel(){
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        //loading the file from app bundle
        if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt"){
            //Load the txt as a String
            if let levelContents = try? String(contentsOf: levelFileURL) {
                //Look a the txt in the project to better understand the process of conversion
                //Create an array splitting the String on each line
                var lines = levelContents.components(separatedBy: "\n")
                //Shuffle the array
                lines.shuffle()
                
                for (index, line) in lines.enumerated() {
                    //Splitting each line in an array of 2 element splitting the line on :
                    let parts = line.components(separatedBy: ": ")
                    //The answer is the left part of the String before the : so after the conversion is in array 0 position
                    let answer = parts[0]
                    //The clue is on the right of the string after the : so after the conversion is in array 1 position
                    let clue = parts[1]
                    
                    clueString += "\(index + 1). \(clue)\n" //Final example --> 1. Ghosts in residence
                    
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "") //Removing the pipe from the answer HA|UNT|ED
                    solutionString += "\(solutionWord.count) letters\n" //Counting the solution letter to give an hint to the user
                    
                    //Add the solution in the solutions array
                    solutions.append(solutionWord)
                    
                    //creating an array from the string HA|UNT|ED. We would use this array to crate the buttons
                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                }
            }
        }
        
        //assign the UILabel text removing white space and new lines from clueString and solutionString at the end of the string, on the last line
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        letterButtons.shuffle()
        
        if letterButtons.count == letterBits.count {
            for i in 0..<letterButtons.count {
                //setting the button text looping from 0 to 20 taking the text from letterBits array
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }
        
    }
}

