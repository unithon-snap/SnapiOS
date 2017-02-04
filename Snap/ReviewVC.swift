//
//  ReviewVC.swift
//  Unithon4rdSnap
//
//  Created by Goodnews on 2017. 2. 4..
//  Copyright © 2017년 goodnews. All rights reserved.
//

import UIKit

class ReviewVC: UIViewController {

    let cellId = "reviewCell"

    var lastOffsetY: CGFloat?
    
    var frameCollectionView: CGRect?
    
    @IBOutlet weak var postReviewButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        
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
    
}


extension ReviewVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    } //  셀 개수
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath as IndexPath) as! ReviewCell
        
        
        
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
        
        print(lastOffsetY)
        
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


