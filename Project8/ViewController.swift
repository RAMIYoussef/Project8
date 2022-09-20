//
//  ViewController.swift
//  Project8
//
//  Created by Mymac on 17/9/2022.
//

import UIKit

class ViewController: UIViewController {
    
    var scoreLabel : UILabel!
    var cluesLabel : UILabel!
    var currentAnswer : UITextField!
    var answerLabel : UILabel!
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var solutionsWords = [String]()
    var submitScore = 0
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var level = 1 {
        didSet{
            
        }
    }
    
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        scoreLabel.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(scoreLabel)
        
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.text = "CLUES"
        cluesLabel.numberOfLines = 0
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(cluesLabel)
        
        
        answerLabel = UILabel()
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.text = "ANSWER"
        answerLabel.numberOfLines = 0
        answerLabel.textAlignment = .right
        answerLabel.font = UIFont.systemFont(ofSize: 24)
        answerLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(answerLabel)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.isUserInteractionEnabled = false
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.textAlignment = .center
        view.addSubview(currentAnswer)
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        view.addSubview(submit)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        view.addSubview(clear)
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        let height = 80
        let width = 150
        
        for i in 0..<4 {
            for j in 0..<5 {
                let letterButtom = UIButton(type: .system)
                letterButtom.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                letterButtom.setTitle("WWW", for: .normal)
                let frame = CGRect(x: j*width, y: i*height, width: width, height: height)
                letterButtom.frame = frame
                letterButtom.layer.borderWidth = 1
                letterButtom.layer.borderColor = UIColor.gray.cgColor
                buttonsView.addSubview(letterButtom)
                letterButtom.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                letterButtons.append(letterButtom)
                
            }
        }
        
        
        
        
        
        //MARK: Constraints
        NSLayoutConstraint.activate([
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
            answerLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
            answerLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
            answerLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            answerLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor, multiplier: 0.5),
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            submit.heightAnchor.constraint(equalToConstant: 44),
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clear.heightAnchor.constraint(equalToConstant: 44),
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
            
        ])
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadLevel()
        
    }
    //MARK: Func
    @objc func submitTapped(_ sender : UIButton){
        guard let answer = currentAnswer.text else{ return}
        if let position = solutionsWords.firstIndex(of: answer){
            activatedButtons.removeAll()
            var splitAnswers = answerLabel.text?.components(separatedBy: "\n")
            print(splitAnswers!)
            splitAnswers?[position] = answer
            answerLabel.text = splitAnswers?.joined(separator: "\n")
            currentAnswer.text?.removeAll()
            score += 1
            submitScore += 1
            
        }else if currentAnswer.text == ""{
            let ac = UIAlertController(title: "Aler!", message: "Try to fil up the answer filde with some letters", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }else{
            let ac = UIAlertController(title: "Wrong !", message: "Try hard you just lose 1 point in your score", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            score -= 1
            clearTapped(sender)
            
        }
        if (submitScore == solutionsWords.count) {
            levelUp()
        }
        
        
    }
    @objc func clearTapped(_ sender : UIButton){
        currentAnswer.text?.removeAll()
        for button in activatedButtons {
            button.isHidden = false
        }
        activatedButtons.removeAll()
        
    }
    @objc func letterTapped(_ sender : UIButton){
        sender.isHidden = true
        activatedButtons.append(sender)
        guard let buttonTitle = sender.currentTitle else {return}
        currentAnswer.text? += buttonTitle
    }
    func loadLevel(){
        var cluesString = ""
        var answerString = ""
        var bitsLetters = [String]()
        if let urlLevel = Bundle.main.url(forResource: "level\(level)", withExtension: "txt"){
            if let levelString = try? String(contentsOf: urlLevel){
                var lines = levelString.components(separatedBy: "\n")
                lines.shuffle()
                for (index,line) in lines.enumerated(){
                    let parts = line.components(separatedBy: ": ")
                    let clue = parts[1]
                    let answer = parts[0]
                    cluesString += "\(index+1). \(clue)\n"
                    let answerWord = answer.replacingOccurrences(of: "|", with: "")
                    answerString += "\(answerWord.count) Letters\n"
                    solutionsWords.append(answerWord)
                    let bits = answer.components(separatedBy: "|")
                    bitsLetters += bits
                }
            }
        }
        cluesLabel.text = cluesString.trimmingCharacters(in: .whitespacesAndNewlines)
        answerLabel.text = answerString.trimmingCharacters(in: .whitespacesAndNewlines)
        print(answerLabel.text!)
        bitsLetters.shuffle()
        
        if letterButtons.count == bitsLetters.count {
            for i in 0..<letterButtons.count {
                letterButtons[i].setTitle(bitsLetters[i], for: .normal)
            }
        }
    }
    
    func levelUp(){
        level += 1
        solutionsWords.removeAll(keepingCapacity: true)
        score = 0
        submitScore = 0
        if level > 2{
            let ac = UIAlertController(title: "Well done!", message: " You reach the final level ", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Let's go!", style: .default))
            present(ac, animated: true)
            level = 1
            for btn in letterButtons {
                btn.isHidden = false
            }
            loadLevel()
        }else{
            let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Let's go!", style: .default))
            present(ac, animated: true)
           
            for btn in letterButtons {
                btn.isHidden = false
            }
            loadLevel()
        }
        
    }
    
    
    
    
    
    
}

