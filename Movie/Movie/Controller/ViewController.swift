//
//  ViewController.swift
//  Movie
//
//  Created by Rajendra Nayak on 5/30/19.
//  Copyright © 2019 Rajendra Solutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var movieBoArray : [MovieBo]!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var collView: UICollectionView!
    @IBOutlet weak var navBarHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collView.transform = CGAffineTransform(scaleX: -1, y: -1)
       
        if (Util.screenSize.height >= 812) {
            navBarHeightConstraint.constant = 92
        }
         loadDatas()
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDatas() {
        Util.showHUD()
        FirebaseHelper.sharedFirebaseHelper.getAllUpcomingMovieList {
            (data) in
            Util.hideHUD()
            self.movieBoArray = data
            if(self.movieBoArray.count > 0){
                self.collView.reloadData()
            }
        }
    }
}

extension ViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if (self.movieBoArray == nil){
            return 0
        }
        return self.movieBoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieBoArray[section].movieArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionCell", for: indexPath) as! MovieCollectionCell
        cell.transform = CGAffineTransform(scaleX: -1, y: -1)
        
        let movie = self.movieBoArray[indexPath.section].movieArray[indexPath.row]
        cell.titleLabel.text = movie.name
        cell.imageView.downloaded(from: movie.image)
       
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
         if (kind == UICollectionView.elementKindSectionFooter) {
            if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionViewHeaderCell", for: indexPath) as? CollectionViewHeaderCell{
                
                headerView.titleLabel.text = self.movieBoArray[indexPath.section].date
                headerView.transform = CGAffineTransform(scaleX: -1, y: -1)
                
                return headerView
            }
        }
        fatalError()
    }
    /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        //print("referenceSizeForHeaderInSection")
        return CGSize(width: collectionView.frame.width, height: 44)
    }*/
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize
    {
        return CGSize(width: collectionView.frame.width, height: 44)
    }
}
extension ViewController : UICollectionViewDelegateFlowLayout
{
    //MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 120, height: 140)
    }
}



