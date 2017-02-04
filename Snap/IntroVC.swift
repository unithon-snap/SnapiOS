//
//  IntroVC.swift
//  Snap
//
//  Created by Goodnews on 2017. 2. 5..
//  Copyright © 2017년 jeon. All rights reserved.
//

import UIKit

class IntroVC: UIViewController {

    
    @IBOutlet weak var normalButton: UIButton!
    
    @IBOutlet weak var photographerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        // Do any additional setup after loading the view.
    }

    func setupViews() {
        normalButton.layer.cornerRadius = 20
        
        photographerButton.layer.cornerRadius = 20
        photographerButton.layer.borderColor = UIColor.darkGray.cgColor
        photographerButton.layer.borderWidth = 1
        photographerButton.setTitleColor(.darkGray, for: .normal)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
