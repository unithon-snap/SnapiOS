//
//  ReviewVC.swift
//  Unithon4rdSnap
//
//  Created by Goodnews on 2017. 2. 4..
//  Copyright © 2017년 goodnews. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ReviewVC: UIViewController {
    
    let cellId = "reviewCell"
    
    var lastOffsetY: CGFloat?
    
    var frameCollectionView: CGRect?
    
    var reviews : [Review] = []
    
    @IBOutlet weak var postReviewButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        getReviews()
        // Do any additional setup after loading the view.
    }
    func setupViews() {
        postReviewButton.layer.cornerRadius = postReviewButton.frame.height / 2
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        frameCollectionView = self.collectionView.frame
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getReviews(){
        
        //서버통신
        //let baseURL = "http://52.78.22.120:3000/api/resume/\(DetailVC.index)/review"
        let baseURL = "http://52.78.22.120:3000/api/resume/1/review"
        
        Alamofire.request(baseURL,method : .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    if response.result.value != nil{
                        
                        //print(response.result.value!)
                        
                        let json = JSON(response.result.value!)
                        
                        print(json)
                        
                        for i in 0..<json.count {
                            
                            self.reviews.append(Review(nickname: json[i]["user_nickname"].stringValue, content: json[i]["review_contents"].stringValue))
                            
                        }
                      
                    }
                    
                    self.collectionView.reloadData()
                    break
                    
                case .failure(_):
                    
                    break
                    
                }
        }
        
        
        
        
    }
    
    
}


extension ReviewVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews.count
    } //  셀 개수
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath as IndexPath) as! ReviewCell
        cell.bodyLabel.text = reviews[indexPath.row].content
        //cell.profileImgView =
        cell.nicknameLabel.text = reviews[indexPath.row].nickname
        
        return cell
    }   // 셀의 내용
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        
        return CGSize(width: collectionView.frame.width, height: 250)
    } // 셀의 높이
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    } // 셀의 간격
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    } // 셀 선택시
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        lastOffsetY = scrollView.contentOffset.y
        
        //print(lastOffsetY)
        
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let hide = scrollView.contentOffset.y > self.lastOffsetY!
        
        if hide {
            let parentVC = self.parent as! DetailVC
            parentVC.closeInfoView()
            
            
        } else {
            let parentVC = self.parent as! DetailVC
            parentVC.openInfoView()
            
        }
    }
    
}


