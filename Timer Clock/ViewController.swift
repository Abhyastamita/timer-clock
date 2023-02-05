//
//  ViewController.swift
//  Timer Clock
//
//  Created by user232612 on 2/4/23.
//

import UIKit
import AVFoundation

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
    var musicPlaying = false
    
    var music : AVAudioPlayer?
    var musicData = NSDataAsset(name: "music")?.data
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        clockFormat.dateFormat = "E, d MMM yyyy HH:mm:ss"
        amPm.dateFormat = "a"
        timerFormat.allowedUnits = [.hour, .minute, .second]
        timerFormat.unitsStyle = .positional
        timerFormat.zeroFormattingBehavior = .pad
        // timerFormat.dateFormat = "HH:mm:ss"
        clockTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.passTime), userInfo: nil, repeats: true)
        music?.numberOfLoops = -1
    }
    
    @IBAction func startTimer(_ sender: UIButton) {
        if (musicPlaying == false) {
            countDownTimer.invalidate()
            timeLeft  = timerPicker.countDownDuration
            
            countDownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(startCountDown), userInfo: nil, repeats: true)
        } else {
            stopMusic()
            timerButton.setTitle("Start Timer", for: .normal)
        }
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
        let timeLeftString = timerFormat.string(from: timeLeft!)!
        timeRemainingLabel.text = "Time Remaining: \(timeLeftString)"
        if timeLeft! >= 0 {
            timeLeft! -= 1
        } else {
            countDownTimer.invalidate()
            playMusic()
            timerButton.setTitle("Stop Music", for: .normal)
        }
    }
    
    func playMusic() {
        do {
            music = try AVAudioPlayer(data: musicData!)
            music!.play()
            musicPlaying = true
            timeRemainingLabel.text = "\u{1F3B5} ~ \u{1F3B5} ~ \u{1F3B5}"
        } catch {
            timeRemainingLabel.text = "Can't play music."
        }
    }
    
    func stopMusic() {
        music?.pause()
        musicPlaying = false
        timeRemainingLabel.text = ""
    }
}

