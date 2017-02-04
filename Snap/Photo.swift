//
//  Photo.swift
//  StackViewPhotoCollage
//
//  Created by Giancarlo on 7/4/15.
//  Copyright (c) 2015 Giancarlo. All rights reserved.
//

import UIKit


let comments = ["#커플  #데이트  #스냅사진  #삼청동  #감성사진  #남여사진  #서울"]
let id = ["id1","id2","id3","id4","id5","id6","id7",]
// Inspired by: RayWenderlich.com pinterest-basic-layout
class Photo: NSObject {
    var image: UIImage
    var tag : String
    var pId : String
    
    init(image: UIImage, tag : String, pId : String) {
        self.image = image
        self.tag = tag
        self.pId = pId
    }
    
    class func allPhotos() -> [Photo] {
        var photos = [Photo]()
        for i in 1..<8 {
            //            let caption = comments[Int(arc4random_uniform(UInt32(comments.count) - UInt32(1)))]
            photos.append(Photo( image: UIImage(named: "image0\(i)")!, tag: comments[0],pId:id[i-1]))
            
            
        }
        return photos
    }
}
