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
    var clockTimer = Timer()
    var clockFormat = DateFormatter()
    var amPm = DateFormatter()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        clockFormat.dateFormat = "E, d MMM yyyy HH:mm:ss"
        amPm.dateFormat = "a"
        clockTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.passTime), userInfo: nil, repeats: true)
        
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


}

