//
//  ViewController.swift
//  Trigger Stop
//
//  Created by T.J. Stone on 5/3/19.
//  Copyright © 2019 T.J. Stone. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // Stores all of the emojis on the screen.
    var emojisInView: [UIImageView] = [UIImageView]()

    @IBOutlet weak var emojiButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        emojiButton.setImage(UIImage(named: "PinkBlueMasks"), for: .normal)
    }
    
    /***
        Creates an Emoji Image view and adds it to the view.
    */
    @IBAction func emojiButtonPressed(_ sender: UIButton) {
        
        let newEmoji = UIImage(named: "PinkBlueMasks")
        let emojiView = UIImageView(image: newEmoji)
        emojiView.frame.size = newEmoji!.size
        
      
        let button_x = self.emojiButton.frame.origin.x
        let button_y = self.emojiButton.frame.origin.y

        emojiView.frame = CGRect(
            x: button_x + 10,
            y: button_y + 10,
            width: newEmoji!.size.width,
            height: newEmoji!.size.height
        )
        
        
       let panGesture = UIPanGestureRecognizer(
        target: self,
        action: #selector(MainViewController.moveEmoji(_:)))
    

        emojiView.isUserInteractionEnabled = true
        emojiView.addGestureRecognizer(panGesture)
        emojisInView.append(emojiView)
        
        print("Emojies in view: \(emojisInView.count)")
        self.view.addSubview(emojiView)
    }
    
    
    var initialCenter = CGPoint()
    
    @objc func moveEmoji(_ sender: UIPanGestureRecognizer) {
        guard sender.view != nil else {return}
        let emojiView = sender.view!
        // Get the changes in the X and Y directions relative to
        // the superview's coordinate space.
        let translation = sender.translation(in: emojiView.superview)
        
        if sender.state == .began {
            // Save the view's original position.
            self.initialCenter = emojiView.center
        }
        if sender.state != .cancelled {
            // Add the X and Y translation to the view's original position.
            let newCenter = CGPoint(
                x: initialCenter.x + translation.x,
                y: initialCenter.y + translation.y)
            emojiView.center = newCenter
        }
        else {
            // On cancellation, return the piece to its original location.
            emojiView.center = initialCenter
        }
    }
}

