//
//  Review.swift
//  Snap
//
//  Created by 전한경 on 2017. 2. 5..
//  Copyright © 2017년 jeon. All rights reserved.
//

import UIKit


// Inspired by: RayWenderlich.com pinterest-basic-layout
class Review: NSObject {
    //var profile: UIImage
    var nickname : String
    var content : String
    
    init(nickname : String, content : String) {
        //self.profile = profile
        self.nickname = nickname
        self.content = content
    }
    
   
}
