//
//  SeatMap.swift
//  Movie Viewer
//
//  Created by Reggie Manuel Cabalo on 15/03/2018.
//  Copyright © 2018 Reggie Manuel Cabalo. All rights reserved.
//

import ObjectMapper

class SeatMap: Mappable {
    
    var seatmap: [[Any]]?
    var available: [String]?
    var seat_count: Int?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        seatmap <- map["seatmap"]
        available <- map["available.seats"]
        seat_count <- map["seat_count"]
    }
}
