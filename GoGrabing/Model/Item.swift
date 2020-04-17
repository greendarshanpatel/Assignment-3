//
//  Item.swift
//  GoGrabing
//
//  Created by Darshan Patel on 2020-03-22.
//  Copyright © 2020 GoGrabing. All rights reserved.
//

import Foundation


public final class Item: Codable {

     public let id : Int
     public let itemTypeID : Int
     public let cost : Double
     public let weight : Double
     public let name: String
     public let image : String
     public let storeId : Int
     public let itemType : ItemType
     public let store : Store
    
    enum CodingKeys: String, CodingKey {
        case id
        case itemTypeID
        case cost
        case weight
        case name
        case image
        case storeId
        case itemType
        case store
    }
    
    init(decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decode(Int.self, forKey: .id)
            itemTypeID = try values.decode(Int.self, forKey: .itemTypeID)
            cost = try values.decode(Double.self, forKey: .cost)
            weight = try values.decode(Double.self, forKey: .weight)
            name = try values.decode(String.self, forKey: .name)
            image = try values.decode(String.self, forKey: .image)
            storeId = try values.decode(Int.self, forKey: .storeId)
            itemType = try values.decode(ItemType.self, forKey: .itemType)
            store = try values.decode(Store.self, forKey: .store)
        }
    }
   
    
    init(id : Int,itemTypeID : Int,cost : Double,weight : Double,storeId : Int, name: String, image : String,itemType : ItemType,  store : Store) {
        self.id = id
        self.itemTypeID = itemTypeID
        self.cost = cost
        self.weight = weight
        self.name = name
        self.image = image
        self.storeId = storeId
        self.itemType = itemType
        self.store = store
    }
}


//{"status":200,"message":"Successfull","data":[{"id":2,"itemTypeID":1,"cost":199.0,"weight":5.0,"name":"Sprite","image":" ","storeId":1,"itemType":{"id":1,"itemType":"Beverage"},"store":{"id":1,"storeName":"Zehrs"}}]}
// https://grabapi.azurewebsites.net/item

public final class Store:Codable {

    public let id : Int
    public let storeName : String
    
    enum CodingKeys: String, CodingKey {
        case id
        case storeName
        
    }
    
    init(decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decode(Int.self, forKey: .id)
            storeName = try values.decode(String.self, forKey: .storeName)
           
        }
    }
}

public final class ItemType:Codable {

    public let id : Int
    public let itemType : String
    
   enum CodingKeys: String, CodingKey {
       case id
       case itemType
       
   }
   
   init(decoder: Decoder) throws {
       do {
           let values = try decoder.container(keyedBy: CodingKeys.self)
           id = try values.decode(Int.self, forKey: .id)
           itemType = try values.decode(String.self, forKey: .itemType)
          
       }
   }
    
}

public final class ItemResponce:Codable {

    public let status : Int
    public let message : String
    public let data : [Item]
    
   enum CodingKeys: String, CodingKey {
       case status
       case message
       case data
       
   }
   
   init(decoder: Decoder) throws {
       do {
           let values = try decoder.container(keyedBy: CodingKeys.self)
           status = try values.decode(Int.self, forKey: .status)
           message = try values.decode(String.self, forKey: .message)
           data = try values.decode([Item].self, forKey: .data)
          
       }
   }
    
    
}

