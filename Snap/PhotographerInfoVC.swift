//
//  PhotographerInfoVC.swift
//  Unithon4rdSnap
//
//  Created by Goodnews on 2017. 2. 4..
//  Copyright © 2017년 goodnews. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PhotographerInfoVC: UIViewController {

    
   
    
    let userDevice = DeviceResize(testDeviceModel: DeviceType.IPHONE_7,userDeviceModel: (Float(ScreenSize.SCREEN_WIDTH),Float(ScreenSize.SCREEN_HEIGHT)))
    
    
    
    var heightRatio: CGFloat = 0.0
    var widthRatio: CGFloat = 0.0
    
    
    
    var starcount : Int = 3
    var slogan : String = ""
    var phoneNumber :String = ""
    var kakao :String = ""
    var emailInfo :String = ""
    var starList : [String] = ["staroff","staroff","staroff","staroff","staroff"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getGrapherInfo()
        heightRatio = userDevice.userDeviceHeight()
        widthRatio = userDevice.userDeviceWidth()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        //alamofire 통신 다음에 오는 곳
        setStarView()
        setView()
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    func getGrapherInfo() {
        
        //서버통신
        let baseURL = "http://ssoma.xyz:3000/v1.0/detailInfo"
       
        let user = UserDefaults.standard
        let result = user.string(forKey: "user")
        
        
        let parameters : Parameters = ["resumIdx":result!]
        
        Alamofire.request(baseURL,method : .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    if response.result.value != nil{
                        
                        //print(response.result.value!)
                        
                        let json = JSON(response.result.value!)
                        
                        print(json)
                        
                        self.kakao = json[0]["resume_kakaoID"].stringValue
                        self.slogan = json[0]["resume_intro"].stringValue
                        self.phoneNumber = json[0]["resume_contact"].stringValue
                        self.emailInfo = json[0]["resume_email"].stringValue
                        self.starcount = json[0]["resume_star"].intValue
                        
                        
                       
                        
                        //self.setView(a: json["resume_intro"].stringValue, b: json["resume_contact"].stringValue,c: json["resume_kakaoID"].stringValue, d: json["resume_email"].stringValue)
                    }
                    
                    break
                    
                case .failure(_):
                    
                    break
                    
                }
        }
        
        
        
        
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
                label.text = slogan
                label.font = UIFont.systemFont(ofSize: 17)
                view.addSubview(label)
        
        let phone = UILabel(frame: CGRect(x:widthRatio*74, y:heightRatio*144, width:58, height: 21))
        phone.textAlignment = NSTextAlignment.left
        phone.text = "Phone"
        phone.font = UIFont.systemFont(ofSize: 13)
        view.addSubview(phone)
        
        let phone1 = UILabel(frame: CGRect(x:widthRatio*173, y:heightRatio*144, width:122, height: 19))
        phone1.textAlignment = NSTextAlignment.left
        phone1.text = phoneNumber
        phone1.font = UIFont.systemFont(ofSize: 12)
        view.addSubview(phone1)
        
        let kt = UILabel(frame: CGRect(x:widthRatio*74, y:heightRatio*160, width:65, height: 21))
        kt.textAlignment = NSTextAlignment.left
        kt.text = "Kakaotalk"
        kt.font = UIFont.systemFont(ofSize: 13)
        view.addSubview(kt)
        
        let kt1 = UILabel(frame: CGRect(x:widthRatio*173, y:heightRatio*160, width:122, height: 19))
        kt1.textAlignment = NSTextAlignment.left
        kt1.text = kakao
        kt1.font = UIFont.systemFont(ofSize: 12)
        view.addSubview(kt1)
        
        let email = UILabel(frame: CGRect(x:widthRatio*74, y:heightRatio*176, width:58, height: 21))
        email.textAlignment = NSTextAlignment.left
        email.text = "E-mail"
        email.font = UIFont.systemFont(ofSize: 13)
        view.addSubview(email)
        
        let email1 = UILabel(frame: CGRect(x:widthRatio*173, y:heightRatio*176, width:145, height: 19))
        email1.textAlignment = NSTextAlignment.left
        email1.text = emailInfo
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
