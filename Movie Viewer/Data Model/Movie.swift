//
//  Movie.swift
//  Movie Viewer
//
//  Created by Reggie Manuel Cabalo on 14/03/2018.
//  Copyright © 2018 Reggie Manuel Cabalo. All rights reserved.
//

import ObjectMapper

class Movie: Mappable {
    var location: String?

    var movieId: String?
    var advisory_rating: String?
    var canonical_title: String?
    var cast: [Cast]?
    var genre: String?
    var has_schedule: Int?
    var is_inactive: Int?
    var is_showing: Int?
    var link_name: String?
    var poster: String?
    var poster_landscape: String?
    var ratings: String?
    var release_date: String?
    var runtime_mins: String?
    var synopsis: String?
    var trailer: String?
    var average_rating: String?
    var total_reviews: String?
    var variants: [Variants]?
    var theater: String?
    var order: Int?
    var is_featured: Bool?
    var your_rating:Int?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        movieId <- map["movie_id"]
        advisory_rating <- map["advisory_rating"]
        canonical_title <- map["canonical_title"]
        cast <- map["cast"]
        genre <- map["genre"]
        has_schedule <- map["has_schedule"]
        is_inactive <- map["is_active"]
        is_showing <- map["is_showing"]
        link_name <- map["link_name"]
        poster <- map["poster"]
        poster_landscape <- map["poster_landscape"]
        ratings <- map["ratings"]
        release_date <- map["release_date"]
        runtime_mins <- map["runtime_mins"]
        synopsis <- map["synopsis"]
        trailer <- map["trailer"]
        average_rating <- map["average_rating"]
        total_reviews <- map["total_reviews"]
        variants <- map["variants"]
        theater <- map["theater"]
        order <- map["order"]
        is_featured <- map["is_featured"]
        your_rating <- map["your_rating"]
    }
}


class Cast: Mappable {
    var actors: [String]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
       actors <- map[""]
    }
}

class Variants: Mappable {
    var variants: [String]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        variants <- map[""]
    }
}

