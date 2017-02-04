//
//  PhotographerInfoVC.swift
//  Unithon4rdSnap
//
//  Created by Goodnews on 2017. 2. 4..
//  Copyright © 2017년 goodnews. All rights reserved.
//

import UIKit

class PhotographerInfoVC: UIViewController {

    
   
    
    let userDevice = DeviceResize(testDeviceModel: DeviceType.IPHONE_7,userDeviceModel: (Float(ScreenSize.SCREEN_WIDTH),Float(ScreenSize.SCREEN_HEIGHT)))
    
    
    
    var heightRatio: CGFloat = 0.0
    var widthRatio: CGFloat = 0.0
    
    
    
    var starcount : Int = 3
    var slogan : String = ""
    var phoneNumber :String = ""
    var kakao :String = ""
    var email :String = ""
    var starList : [String] = ["staroff","staroff","staroff","staroff","staroff"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        heightRatio = userDevice.userDeviceHeight()
        widthRatio = userDevice.userDeviceWidth()
        setStarView()
        setView()
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setStarView(){
        
        for i in 0..<starcount{
            starList[i] = "staron"
        }
    }
    
    func setView(){
        
        
                let star1 = UIImageView(frame: CGRect(x: 113*widthRatio, y: 44*heightRatio, width: 20*widthRatio, height: 20*heightRatio))
                star1.image = UIImage(named: starList[0])
                //mainLogo.sizeToFit()
                view.addSubview(star1)
        
        let star2 = UIImageView(frame: CGRect(x: 145*widthRatio, y: 44*heightRatio, width: 20*widthRatio, height: 20*heightRatio))
        star2.image = UIImage(named: starList[1])
        //mainLogo.sizeToFit()
        view.addSubview(star2)
        
        let star3 = UIImageView(frame: CGRect(x: 177*widthRatio, y: 44*heightRatio, width: 20*widthRatio, height: 20*heightRatio))
        star3.image = UIImage(named: starList[2])
        //mainLogo.sizeToFit()
        view.addSubview(star3)
        
        let star4 = UIImageView(frame: CGRect(x: 209*widthRatio, y: 44*heightRatio, width: 20*widthRatio, height: 20*heightRatio))
        star4.image = UIImage(named: starList[3])
        //mainLogo.sizeToFit()
        view.addSubview(star4)
        
        let star5 = UIImageView(frame: CGRect(x: 241*widthRatio, y: 44*heightRatio, width: 20*widthRatio, height: 20*heightRatio))
        star5.image = UIImage(named: starList[4])
        //mainLogo.sizeToFit()
        view.addSubview(star5)
        
                let label = UILabel(frame: CGRect(x:widthRatio*0, y:heightRatio*94, width:375, height: 19))
                label.textAlignment = NSTextAlignment.center
                label.text = "당신의 가장 빛나는 순간을 담겠습니다."
                label.font = UIFont.systemFont(ofSize: 17)
                view.addSubview(label)
        
        let phone = UILabel(frame: CGRect(x:widthRatio*74, y:heightRatio*144, width:58, height: 21))
        phone.textAlignment = NSTextAlignment.left
        phone.text = "Phone"
        phone.font = UIFont.systemFont(ofSize: 13)
        view.addSubview(phone)
        
        let phone1 = UILabel(frame: CGRect(x:widthRatio*173, y:heightRatio*144, width:122, height: 19))
        phone1.textAlignment = NSTextAlignment.left
        phone1.text = "010-2312-0032"
        phone1.font = UIFont.systemFont(ofSize: 12)
        view.addSubview(phone1)
        
        let kt = UILabel(frame: CGRect(x:widthRatio*74, y:heightRatio*160, width:65, height: 21))
        kt.textAlignment = NSTextAlignment.left
        kt.text = "Kakaotalk"
        kt.font = UIFont.systemFont(ofSize: 13)
        view.addSubview(kt)
        
        let kt1 = UILabel(frame: CGRect(x:widthRatio*173, y:heightRatio*160, width:122, height: 19))
        kt1.textAlignment = NSTextAlignment.left
        kt1.text = "dnsklegls20"
        kt1.font = UIFont.systemFont(ofSize: 12)
        view.addSubview(kt1)
        
        let email = UILabel(frame: CGRect(x:widthRatio*74, y:heightRatio*176, width:58, height: 21))
        email.textAlignment = NSTextAlignment.left
        email.text = "E-mail"
        email.font = UIFont.systemFont(ofSize: 13)
        view.addSubview(email)
        
        let email1 = UILabel(frame: CGRect(x:widthRatio*173, y:heightRatio*176, width:145, height: 19))
        email1.textAlignment = NSTextAlignment.left
        email1.text = "dnsklegls20@gmail.com"
        email1.font = UIFont.systemFont(ofSize: 12)
        view.addSubview(email1)
        
        
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
