//
//  User+CoreDataProperties.swift
//  StayFitShop
//
//  Created by Viktor Mauzer on 03.06.2022..
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var address: String?
    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var zip: String?
    
    var wrappedAddress: String {
        address ?? ""
    }
    
    var wrappedCity: String {
        city ?? ""
    }
    
    var wrappedCountry: String {
        country ?? ""
    }
    
    var wrappedFirstName: String {
        firstName ?? ""
    }
    
    var wrappedLastName: String {
        lastName ?? ""
    }
    
    var wrappedZip: String {
        zip ?? ""
    }

}

extension User : Identifiable {

}
