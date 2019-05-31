//
//  FirebaseHelper.swift
//  Movie
//
//  Created by Rajendra Nayak on 5/31/19.
//  Copyright © 2019 Rajendra Solutions. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FirebaseHelper {
    static var sharedFirebaseHelper:FirebaseHelper! = FirebaseHelper()
    private init(){
    }
    func getAllUpcomingMovieList(completion: @escaping (_ result: [MovieBo]) -> Void){
        var ref: DatabaseReference!
        var databaseHandle: DatabaseHandle!
        ref = Database.database().reference()
        databaseHandle = ref.child("ReleaseDates").observe(DataEventType.value, with: { (mainData) in
            var movieBoArray = [MovieBo]()
            
            if let mainArray = mainData.value as? [[String : AnyObject]] {
                
                for dict in mainArray{
                    let movieBo = MovieBo(data: dict)
                    movieBoArray.append(movieBo)
                }
           }
            completion(movieBoArray)
            
        })
        
    }
    /*func readData1(){
     var ref: DatabaseReference!
     var databaseHandle: DatabaseHandle!
     self.movieBoArray = [MovieBo]()
     
     ref = Database.database().reference().child("ReleaseDates")
     
     ref.queryOrdered(byChild: "date").observe(.childAdded, with: {
     (snapshot) in
     
     if let dictionary = snapshot.value as? [String:AnyObject]{
     debugPrint(dictionary)
     let movieBo = MovieBo(data: dictionary)
     self.movieBoArray.append(movieBo)
     }
     if(self.movieBoArray.count > 0){
     self.collView.reloadData()
     }
     })
     }*/
    
}
