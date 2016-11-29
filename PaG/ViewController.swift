//
//  ViewController.swift
//  PaG
//
//  Created by Hiroki on 2016/11/16.
//  Copyright © 2016年 Brainya. All rights reserved.
//

import UIKit

enum FadeType: TimeInterval {
    case
    Normal = 0.5,
    Slow = 1.0
}

extension UILabel {
    func fadeIn(type: FadeType = .Normal, completed: (() -> ())? = nil) {
        fadeIn(duration: type.rawValue, completed: completed)
    }
    
    /** For typical purpose, use "public func fadeIn(type: FadeType = .Normal, completed: (() -> ())? = nil)" instead of this */
    func fadeIn(duration: TimeInterval = FadeType.Slow.rawValue, completed: (() -> ())? = nil) {
        alpha = 0
        isHidden = false
        UIView.animate(withDuration: duration,
                                   animations: {
                                    self.alpha = 1
        }) { finished in
            completed?()
        }
    }
    func fadeOut(type: FadeType = .Normal, completed: (() -> ())? = nil) {
        fadeOut(duration: type.rawValue, completed: completed)
    }
    /** For typical purpose, use "public func fadeOut(type: FadeType = .Normal, completed: (() -> ())? = nil)" instead of this */
    func fadeOut(duration: TimeInterval = FadeType.Slow.rawValue, completed: (() -> ())? = nil) {
        UIView.animate(withDuration: duration
            , animations: {
                self.alpha = 0
        }) { [weak self] finished in
            self?.isHidden = true
            self?.alpha = 1
            completed?()
        }
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var NoticeLabel: UILabel!
    @IBOutlet weak var GeneratedPasswordLabel: UILabel!
    @IBOutlet weak var DigitNumberSegCtrl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func RegeneratePasswordTapped(_ sender: UIButton) {
        let digits: [String] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "n", "m", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "N", "M", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        let digitNumber: Int = Int(DigitNumberSegCtrl.titleForSegment(at: DigitNumberSegCtrl.selectedSegmentIndex)!)!
        var password: String = ""
        
        for _ in 1...digitNumber {
            password.append(digits[Int(arc4random() % 62)])
        }
        
        GeneratedPasswordLabel.fadeIn(type: .Normal)
        GeneratedPasswordLabel.text = password
    }

    @IBAction func CopyPasswordTapped(_ sender: UIButton) {
        let password: String = GeneratedPasswordLabel.text!
        
        UIPasteboard.general.string = password
        NoticeLabel.fadeIn(type: .Normal)
        NoticeLabel.text = "Copied."
        NoticeLabel.fadeOut(type: .Slow)
    }
}

