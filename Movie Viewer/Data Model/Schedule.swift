//
//  Schedule.swift
//  Movie Viewer
//
//  Created by Reggie Manuel Cabalo on 15/03/2018.
//  Copyright © 2018 Reggie Manuel Cabalo. All rights reserved.
//

import ObjectMapper

class Schedule: Mappable {
    
    var dates: [Dates]?
    var cinemas: [Cinemas]?
    var times: [Times]?
   
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        dates <- map["dates"]
        cinemas <- map["cinemas"]
        times <- map["times"]
    }
}

class Dates: Mappable {
    var id: String?
    var label: String?
    var date: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        label <- map["label"]
        date <- map["date"]
    }
}

class Cinemas: Mappable {
    var parent: String?
    var cinemas: [CinemasDetails]?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        parent <- map["parent"]
        cinemas <- map["cinemas"]
    }
}

class CinemasDetails: Mappable {
    var id: String?
    var cinema_id: String?
    var label: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        cinema_id <- map["cinema_id"]
        label <- map["label"]
    }
}

class Times: Mappable {
    var parent: String?
    var times: [TimesDetails]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        parent <- map["parent"]
        times <- map["times"]
    }
}

class TimesDetails: Mappable {
    var id: String?
    var label: String?
    var schedule_id: String?
    var popcorn_price: String?
    var popcorn_label: String?
    var seating_type: String?
    var price: String?
    var variant: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        label <- map["label"]
        schedule_id <- map["schedule_id"]
        popcorn_price <- map["popcorn_price"]
        popcorn_label <- map["popcorn_label"]
        seating_type <- map["seating_type"]
        price <- map["price"]
        variant <- map["variant"]
    }
}
