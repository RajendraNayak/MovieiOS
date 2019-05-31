//
//  Movie.swift
//  Movie
//
//  Created by Rajendra Nayak on 5/31/19.
//  Copyright © 2019 Rajendra Solutions. All rights reserved.
//

import UIKit

class MovieBo {
    var date:String!
    var movieArray = [Movie]()
    init(data:[String:AnyObject]){
        if let date = data["date"] as? String{
            self.date = date
        }
        if let movieMainArray = data["movie"] as? [[String:AnyObject]]{
            for dict in movieMainArray{
                let movie = Movie(data: dict)
                self.movieArray.append(movie)
            }
            self.movieArray.sort {$0.name < $1.name}
        }
        
    }
}
class Movie {
    var name:String!
     var image:String!
    init(data:[String:AnyObject]){
        if let name = data["name"] as? String{
            self.name = name
        }
        
        if let image = data["image"] as? String{
            self.image = image
        }
    }
}
