//
//  ViewController.swift
//  Timer Clock
//
//  Created by user232612 on 2/4/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var clock: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var timerPicker: UIDatePicker!
    
    var clockTimer = Timer()
    var clockFormat = DateFormatter()
    var amPm = DateFormatter()
    var timerFormat = DateComponentsFormatter()
    var countDownTimer = Timer()
    var timeLeft : TimeInterval?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        clockFormat.dateFormat = "E, d MMM yyyy HH:mm:ss"
        amPm.dateFormat = "a"
        // timerFormat.dateFormat = "HH:mm:ss"
        clockTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.passTime), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func startTimer(_ sender: UIButton) {
        countDownTimer.invalidate()
        timeLeft  = timerPicker.countDownDuration
        
        countDownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(startCountDown), userInfo: nil, repeats: true)
        
    }
    
    @objc func passTime() {
        clock.text = clockFormat.string(from: Date())
        if (amPm.string(from: Date()) == "AM") {
            backgroundImage.image = UIImage(named: "dayBackground")
            backgroundImage.alpha = 0.7
        } else {
            backgroundImage.image = UIImage(named: "nightBackground")
            backgroundImage.alpha = 1.0
        }
    }
    
    @objc func startCountDown() {
        timeRemainingLabel.text = timerFormat.string(from: timeLeft!)
        if timeLeft! >= 0 {
            timeLeft! -= 1
        } else {
            countDownTimer.invalidate()
        }
    }


}

