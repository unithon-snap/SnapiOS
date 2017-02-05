//
//  PostReviewVC.swift
//  Snap
//
//  Created by Goodnews on 2017. 2. 5..
//  Copyright © 2017년 jeon. All rights reserved.
//

import UIKit

class PostReviewVC: UIViewController, UITextViewDelegate {

    
    
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var postButton: UIButton!
    
    let placeholderText = "작가님이 되게 친절하시구 재밌으셔서 촬영 내내 즐거웠네요~ 작가님이 되게 친절하시구 재밌으셔서 촬영 내내 즐거웠네요~"
    override func viewDidLoad() {
        super.viewDidLoad()

        
        bodyTextView.text = placeholderText
        
        postButton.layer.cornerRadius = 20
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        bodyTextView.resignFirstResponder()
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            textView.text = ""
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didTapPost(_ sender: Any) {
        print("전송완료")
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func didTapBack(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
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
