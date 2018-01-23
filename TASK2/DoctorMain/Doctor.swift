//
//  Doctor.swift
//  TASK2
//
//  Created by Macbook on 1/16/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import Foundation


class Doctor
{
    var id : String?
    var name : String?
    var photoId : String?
    var rating : String?
    var address : String?
    var lat : Double?
    var lng : Double?
    var highlighted : Bool?
    var reviewCount : UInt?
    var specialityIds :[Int]?
    var source : String?
    var phoneNumber : String?
    var email : String?
    var website : String?
    var openingHours : [Double]?
    
    init(id:String,name:String,photoId:String,rating:String,address:String,lat:Double,lng:Double, highlighted:Bool,reviewCount:UInt,specialityIds:[Int],source:String,phoneNumber:String,email:String,website:String,openingHours:[Double])
    {
        self.id=id
        self.name=name
        self.photoId=photoId
        self.rating=rating
        self.address=address
        self.lat=lat
        self.lng=lng
        self.highlighted=highlighted
        self.reviewCount=reviewCount
        self.specialityIds=specialityIds
        self.source=source
        self.phoneNumber=phoneNumber
        self.email=email
        self.website=website
        self.openingHours=openingHours
        
    }
    
    
    
    init?(dictionary :JSONDictionary) {
        
        guard let id = dictionary["id"] as? String,
          let name = dictionary["name"] as? String,
            let photoId = dictionary["photoId"] as? String,
            let rating = dictionary["rating"] as? String,
            let address = dictionary["address"] as? String,
            let lat = dictionary["lat"] as? Double,
            let lng = dictionary["lng"] as? Double,
            let highlighted = dictionary["highlighted"] as? Bool,
            let reviewCount = dictionary["reviewCount"] as? UInt,
            let specialityIds = dictionary["specialityIds"] as? [Int],
            let source = dictionary["source"] as? String,
            let phoneNumber = dictionary["phoneNumber"] as? String,
            let email = dictionary["email"] as? String,
            let website = dictionary["website"] as? String,
            let openingHours = dictionary["openingHours"] as? [Double] else {
                return
        }
        
        self.id = id
        self.name = name
        self.photoId=photoId
        self.rating=rating
        self.address=address
        self.lat=lat
        self.lng=lng
        self.highlighted=highlighted
        self.reviewCount=reviewCount
        self.specialityIds=specialityIds
        self.source=source
        self.phoneNumber=phoneNumber
        self.email=email
        self.website=website
        self.openingHours=openingHours
        
    }
}




/*
 "id": "ChIJi0mJVvpRqEcR44v5lAoId-U",
 "name": "Andrea Link",
 "photoId": null,
 "rating": 0,
 "address": "Zionskirchstraße 11, 10119 Berlin, Germany",
 "lat": 52.53548629999999,
 "lng": 13.4017685,
 "highlighted": false,
 "reviewCount": null,
 "specialityIds": [
 1
 ],
 "source": "google",
 "phoneNumber": "+49 30 48623451",
 "email": null,
 "website": null,
 "openingHours": []
 },
 */
