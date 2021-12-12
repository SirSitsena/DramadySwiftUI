//
//  LocalMovie+CoreDataProperties.swift
//  Dramady
//
//  Created by Rasmus Kolmodin on 2021-12-12.
//
//

import Foundation
import CoreData


extension LocalMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalMovie> {
        return NSFetchRequest<LocalMovie>(entityName: "LocalMovie")
    }

    @NSManaged public var titleId: String?
    @NSManaged public var title: String?
    @NSManaged public var image: String?
    @NSManaged public var isFavourited: Bool

}

extension LocalMovie : Identifiable {

}
