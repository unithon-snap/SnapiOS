//
//  Photo.swift
//  StackViewPhotoCollage
//
//  Created by Giancarlo on 7/4/15.
//  Copyright (c) 2015 Giancarlo. All rights reserved.
//

import UIKit


let comments = ["#커플  #데이트  #스냅사진  #삼청동  #감성사진  #남여사진  #서울"
]

// Inspired by: RayWenderlich.com pinterest-basic-layout
class Photo: NSObject {
    var image: UIImage
    var text : String
    
    init(image: UIImage, text : String) {
        self.image = image
        self.text = text
    }
    
    class func allPhotos() -> [Photo] {
        var photos = [Photo]()
        for i in 1..<8 {
            let caption = comments[Int(arc4random_uniform(UInt32(comments.count) - UInt32(1)))]
            photos.append(Photo( image: UIImage(named: "image0\(i)")!, text: caption))
            
            
        }
        return photos
    }
}
