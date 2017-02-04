//
//  ShadyImageView.swift
//  event
//
//  Created by Goodnews on 2016. 12. 12..
//  Copyright © 2016년 xsync. All rights reserved.
//

import UIKit

@IBDesignable class ShadyImageView: UIImageView {

    /// 그림자 위치
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 2) {
        didSet{
            setupViews()
        }
    }
    
    func setupViews() {
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        self.layer.shadowOffset = self.shadowOffset

        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 1.0
        
    }
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        setupViews()
    }
    


}
