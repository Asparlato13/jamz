//
//  WelcomeViewController.swift
//  JamzApp
//
//  Created by Adrianna Parlato on 10/11/22.
//

import UIKit

class WelcomeViewController: UIViewController {

    
    @IBOutlet weak var logoImage: UIImageView!
    
   
    @IBOutlet weak var loveLabel: UILabel!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [ UIColor.systemPurple.cgColor,
                                   UIColor.systemIndigo.withAlphaComponent(255/255).cgColor,
       
                                   UIColor.systemTeal.cgColor,
                                   UIColor.systemGreen.withAlphaComponent(30/255).cgColor,
       
                       ]
                  gradient.locations = [0.34, 0.55, 0.8,1]

        return gradient
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        super.viewDidLoad()
        gradient.frame = view.bounds
        view.layer.insertSublayer(gradient, at: 0)
        view.bringSubviewToFront(loginButton)
        view.bringSubviewToFront(logoImage)
        view.bringSubviewToFront(welcomeLabel)
        view.bringSubviewToFront(loveLabel)
        
        
        
    }
    

   

}
