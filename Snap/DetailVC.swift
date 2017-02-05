//
//  ViewController.swift
//  Unithon4rdSnap
//
//  Created by Goodnews on 2017. 2. 4..
//  Copyright © 2017년 goodnews. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    // Mark: 한경님께 전달받을 변수
    
    
    //var id: String = ""
    
    //---------------------------------
    
    let cellId = "photoCell"
    var cellHeight: CGFloat = 0
    
    var lastOffsetY: CGFloat?
    
    static var index = ""
    
    // 위 정보뷰 UI들
    @IBOutlet weak var infoView: UIView! // 바탕 뷰
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var jobLabel: UILabel! // photographer
    @IBOutlet weak var profileNameLabel: UILabel! // Goodnews
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    // 세그먼트에 따라 바뀔 뷰
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var photographerInfoView: UIView!
    @IBOutlet weak var reviewView: UIView!

    var frameInfoView: CGRect?
    var frameProfileImageView: CGRect?
    var frameJobLabel: CGRect?
    var frameNameLabel: CGRect?
    var frameSegControl: CGRect?
    var frameCollectionView: CGRect?
    
    var sampleImages:[UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = UserDefaults.standard
        let result = user.string(forKey: "user")
        //id = result!
        
        sampleImages = [UIImage(data: NSData(contentsOf: NSURL(string: "http://ssoma.xyz:3000/imgs/\(result!)/pic_\(0).png")! as URL)! as Data)!,
                        UIImage(data: NSData(contentsOf: NSURL(string: "http://ssoma.xyz:3000/imgs/\(result!)/pic_\(1).png")! as URL)! as Data)!,
                        UIImage(data: NSData(contentsOf: NSURL(string: "http://ssoma.xyz:3000/imgs/\(result!)/pic_\(2).png")! as URL)! as Data)!,
                        UIImage(data: NSData(contentsOf: NSURL(string: "http://ssoma.xyz:3000/imgs/\(result!)/pic_\(3).png")! as URL)! as Data)!,
                        UIImage(data: NSData(contentsOf: NSURL(string: "http://ssoma.xyz:3000/imgs/\(result!)/pic_\(4).png")! as URL)! as Data)!]
        setupViews()
        getInfoFromServer()
        
        //DetailVC.index = id
        //print("aaa")
        //print(DetailVC.index)
    }
    
    func getInfoFromServer(){
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        rememberFrame()
    }
    func setupViews() {
        
        jobLabel.adjustsFontSizeToFitWidth = true
        cellHeight = self.view.frame.width * (9/16)
        
        self.collectionView.alpha = 1
        self.photographerInfoView.alpha = 0
        self.reviewView.alpha = 0
    }
    
    func rememberFrame() {
        frameInfoView = infoView.frame
        frameProfileImageView = profileImageView.frame
        frameJobLabel = jobLabel.frame
        frameNameLabel = profileNameLabel.frame
        frameSegControl = segmentedControl.frame
        frameCollectionView = collectionView.frame
    }
    
    // 세그먼트 컨트롤러 값 바뀌었을 때
    @IBAction func didChangedSegValue(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: // 포트폴리오
            UIView.animate(withDuration: 0.3, animations: {
                self.collectionView.alpha = 1
                self.photographerInfoView.alpha = 0
                self.reviewView.alpha = 0
                
            })
        case 1: // 작가 정보
            UIView.animate(withDuration: 0.3, animations: {
                self.collectionView.alpha = 0
                self.photographerInfoView.alpha = 1
                self.reviewView.alpha = 0
                
            })
        case 2: // 리뷰
            UIView.animate(withDuration: 0.3, animations: {
                self.collectionView.alpha = 0
                self.photographerInfoView.alpha = 0
                self.reviewView.alpha = 1
                
            })
        default:
            return
        }
    }
    
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension DetailVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    } //  셀 개수
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath as IndexPath) as! PhotoCell
        cell.imgView.image = sampleImages[indexPath.row]
        let imgSize = cell.imgView.image?.size
        
        cell.imgRatio = (imgSize?.width)! / (imgSize?.height)!
        
        return cell
    }   // 셀의 내용
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let imgSize = sampleImages[indexPath.row].size
        let imgRatio = (imgSize.height) / (imgSize.width)


        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width * imgRatio)
    } // 셀의 높이
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    } // 셀의 간격
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        closeInfoView()
    } // 셀 선택시
    
    
    
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        lastOffsetY = scrollView.contentOffset.y
        
        //print(lastOffsetY)
        
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let hide = scrollView.contentOffset.y > self.lastOffsetY!
        
        if hide {
            closeInfoView()
        } else {
            openInfoView()
        }
    }
    
    func closeInfoView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.infoView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64)
            self.profileImageView.frame = CGRect(x: self.view.frame.width / 2, y: 20, width: 0, height: 0)
            self.profileNameLabel.center = CGPoint(x: 188, y: 48)
            self.collectionView.frame = CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height - 64)
            self.jobLabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0)
            self.segmentedControl.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0)
            
            self.jobLabel.alpha = 0
            self.segmentedControl.alpha = 0
            self.profileImageView.alpha = 0
            
            self.reviewView.frame = CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height - 64)
        })
        
        
    }
    
    func openInfoView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.infoView.frame = self.frameInfoView!
            self.profileImageView.frame = self.frameProfileImageView!
            self.profileNameLabel.frame = self.frameNameLabel!
            self.collectionView.frame = self.frameCollectionView!
            self.reviewView.frame = self.frameCollectionView!

            self.jobLabel.frame = self.frameJobLabel!
            self.segmentedControl.frame = self.frameSegControl!
            
            self.jobLabel.alpha = 1
            self.segmentedControl.alpha = 1
            self.profileImageView.alpha = 1

        })
    }
    
}

