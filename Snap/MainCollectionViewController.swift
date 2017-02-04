//
//  ImageFeedViewController.swift
//  StackViewPhotoCollage
//
//  Created by Giancarlo on 7/4/15.
//  Copyright (c) 2015 Giancarlo. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
import SwiftyJSON
// Inspired by: RayWenderlich.com pinterest-basic-layout

class MainCollectionViewController: UICollectionViewController {
    
    struct BUTTON{
        static let MENU = 0
        static let SEARCH = 1
    }
    
    let userDevice = DeviceResize(testDeviceModel: DeviceType.IPHONE_7,userDeviceModel: (Float(ScreenSize.SCREEN_WIDTH),Float(ScreenSize.SCREEN_HEIGHT)))
    
    
    
    var heightRatio: CGFloat = 0.0
    var widthRatio: CGFloat = 0.0
    
    
    // 기기의 너비와 높이
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    
    // MARK: Layout Concerns
    let cellStyle = BeigeRoundedPhotoCaptionCellStyle()
    let reuseIdentifier = "PhotoCaptionCell"
    let collectionViewBottomInset: CGFloat = 10
    let collectionViewSideInset: CGFloat = 5
    let collectionViewTopInset: CGFloat = UIApplication.shared.statusBarFrame.height
    
    var numberOfColumns: Int = 2
    let layout = MultipleColumnLayout()
    
    // MARK: Data
    //fileprivate let photos = Photo.allPhotos()
    var photos : [Photo] = []
    
    required init(coder aDecoder: NSCoder) {
        let layout = MultipleColumnLayout()
        super.init(collectionViewLayout: layout)
        layout.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heightRatio = userDevice.userDeviceHeight()
        widthRatio = userDevice.userDeviceWidth()
        
        loadPhotos()
        
        setUpUI()
    }
    
    
    override func viewWillTransition(
        to size: CGSize,
        with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        guard let collectionView = collectionView,
            let layout = collectionView.collectionViewLayout as? MultipleColumnLayout else {
                return
        }
        layout.clearCache()
        layout.invalidateLayout()
    }
    
    func loadPhotos() {
        
        //서버통신
        let baseURL = "http://ssoma.xyz:3000/v1.0/getData"
        
        Alamofire.request(baseURL,method : .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    if response.result.value != nil{
                        
                        //print(response.result.value!)
                        
                        let json = JSON(response.result.value!)
                        
                        print(json)
                        print(json.count)
                        
                        
                        //                                for i in 0..<json.count{
                        //
                        //                                    print(json[i]["resume_idx"].int!.description)
                        //                                }
                        
                        
                        //print(json[2]["resume_tag"].string!)
                        //print(json["portfolio_picure_1"].stringValue)
                        //print(json["resume_idx"].int?.description)
                        
                        for i in 0..<json.count {
                            
                            
                            //                                    if let images = json[i]["portfolio_picure_1"].string, let tags = json[i]["resume_tag"].string, let idxs = json[i]["resume_idx"].string{
                            //                                        print("asfdfdsfd")
                            //                                    photos.append(Photo( image: UIImage(data: NSData(contentsOf: NSURL(string: images)! as URL)! as Data)!, tag: tags, pId: idxs))
                            //                                    }
                            
                            
                            //let images = json[i]["portfolio_picure_1"].string
                            let tags = json[i]["resume_tag"].string
                            let idxs = json[i]["resume_idx"].int!.description
                            
                            let url = "http://ssoma.xyz:3000/imgs/\(idxs)/pic_\(0).png"
                            print(url)
                            self.photos.append(Photo( image: UIImage(data: NSData(contentsOf: NSURL(string: url)! as URL)! as Data)!, tag: tags!, pId: idxs))
                            
                            //self.photos.append(Photo( image: UIImage(named:"image0\(i+1)")!, tag: tags!, pId: idxs))
                        }
                        
                        
                        self.collectionView?.reloadData()
                    }
                    break
                    
                case .failure(_):
                    
                    break
                    
                }
        }
        
        
        
        
    }
    
    // MARK: Private
    
    fileprivate func setUpUI() {
        // Set background
        //        if let patternImage = UIImage(named: "pattern") {
        //            view.backgroundColor = UIColor(patternImage: patternImage)
        //        }
        view.backgroundColor = UIColor.white
        
        // Set title
        title = "Variable height layout"
        
        // Set generic styling
        collectionView?.backgroundColor = UIColor.clear
        collectionView?.contentInset = UIEdgeInsetsMake(
            collectionViewTopInset,
            collectionViewSideInset,
            collectionViewBottomInset,
            collectionViewSideInset)
        
        // Set layout
        guard let layout = collectionViewLayout as? MultipleColumnLayout else {
            return
        }
        
        layout.cellPadding = collectionViewSideInset
        layout.numberOfColumns = numberOfColumns
        
        //        let label = UILabel(frame: CGRect(x:width/2-50, y:height/5-50, width:100, height: 100))
        //        label.textAlignment = NSTextAlignment.center
        //        label.text = "공개된"
        //        collectionView?.addSubview(label)
        //
        //
        //        let label2 = UILabel(frame: CGRect(x:width/2-50, y:height/4-60, width:100, height: 100))
        //        label2.textAlignment = NSTextAlignment.center
        //        label2.text = "리스트"
        //        collectionView?.addSubview(label2)
        
        let menu = UIButton(type: .system) // let preferred over var here
        
        //button.setTitle("명예의 전당", for: UIControlState.normal)
        
        menu.frame = CGRect(x:9*widthRatio, y:29*heightRatio, width:20, height: 20)
        menu.setImage(UIImage(named:"menu"), for: .normal)
        menu.tintColor = UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 1.0)
        // button.addTarget(self, action: "Action:", for: UIControlEvents.touchUpInside)
        menu.tag = BUTTON.MENU
        menu.addTarget(self, action:#selector(buttonPressed(sender:)), for: .touchUpInside)
        collectionView?.addSubview(menu)
        
        
        let search = UIButton(type: .system) // let preferred over var here
        
        //button.setTitle("명예의 전당", for: UIControlState.normal)
        
        search.frame = CGRect(x:330*widthRatio, y:29*heightRatio, width:25, height: 25)
        search.setImage(UIImage(named:"search"), for: .normal)
        search.tintColor = UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 1.0)
        //search.addTarget(self, action:#selector(action(text:)), for: UIControlEvents.touchUpInside)
        search.tag = BUTTON.SEARCH
        
        // 파라미터 가 없을 경우
        //search.addTarget(self, action:#selector(buttonPressed), for: .touchUpInside)
        // 파라미터가 sender인 경우
        search.addTarget(self, action:#selector(buttonPressed(sender:)), for: .touchUpInside)
        
        collectionView?.addSubview(search)
        
        
        let mainLogo = UIImageView(frame: CGRect(x: 149*widthRatio, y: 73*heightRatio, width: 78*widthRatio, height: 78*heightRatio))
        mainLogo.image = UIImage(named: "icon")
        //mainLogo.sizeToFit()
        collectionView?.addSubview(mainLogo)
        
        
        //
        //        let items = ["최신순", "인기순"]
        //        let customSC = UISegmentedControl(items: items)
        //        customSC.selectedSegmentIndex = 0
        //        customSC.frame = CGRect(x:5 , y:height/2.5,
        //                                width:width-20, height:height/20)
        //        customSC.layer.cornerRadius = 5.0  // Don't let background bleed
        //        customSC.backgroundColor = UIColor.white
        //        customSC.tintColor = UIColor.darkGray
        //
        //
        //         collectionView?.addSubview(customSC)
        
        
        // Register cell identifier
        self.collectionView?.register(PhotoCaptionCell.self,
                                      forCellWithReuseIdentifier: self.reuseIdentifier)
    }
    
    
    
    func buttonPressed(sender: UIButton!) {
        
        
        switch sender.tag {
        case BUTTON.MENU:
            print("menu clicked")
        case BUTTON.SEARCH:
            print("button clicked")
        //self.performSegue(withIdentifier:"ToNext", sender: self)
        default:
            print("default")
        }
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "ToNext"{
    //
    //            print("segueToNext segue execute")
    //        }
    //    }
    
}

// MARK: UICollectionViewDelegate

extension MainCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier,
                                 for: indexPath) as? PhotoCaptionCell
            else {
                fatalError("Could not dequeue cell")
        }
        cell.setUpWithImage(photos[indexPath.item].image,
                            title: photos[indexPath.item].tag,
                            style: BeigeRoundedPhotoCaptionCellStyle())
        cell.layer.borderWidth = 0.0
        cell.isUserInteractionEnabled = true
        
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
        
        
        let storyboard = UIStoryboard(name: "DetailPhotographer", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! DetailVC
        
        controller.id = photos[indexPath.row].pId
        present(controller, animated: true, completion: nil)
        
        //        self.performSegue(withIdentifier:"ToDetail", sender: self)
        //        let controller = self.storyboard?.instantiateViewController(withIdentifier: "secondVC")
        //        self.present(controller!, animated: true, completion: nil)
    }
}

// MARK: MultipleColumnLayoutDelegate

extension MainCollectionViewController: MultipleColumnLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        heightForPhotoAtIndexPath indexPath: IndexPath,
                        withWidth width: CGFloat) -> CGFloat {
        let photo = photos[indexPath.item]
        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        return AVMakeRect(aspectRatio: photo.image.size, insideRect: boundingRect).height
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        heightForAnnotationAtIndexPath indexPath: IndexPath,
                        withWidth width: CGFloat) -> CGFloat {
        
        let rect = NSString(string: photos[indexPath.item].tag)
            .boundingRect(
                with: CGSize(width: width,
                             height: CGFloat(MAXFLOAT)),
                options: .usesLineFragmentOrigin,
                attributes: [NSFontAttributeName: cellStyle.titleFont],
                context: nil)
        
        
        return ceil(rect.height + cellStyle.titleInsets.top + cellStyle.titleInsets.bottom)
    }
}
