//
//  Movie+CoreDataProperties.swift
//  Dramady
//
//  Created by Rasmus Kolmodin on 2021-12-12.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var titleId: String?
    @NSManaged public var title: String?
    @NSManaged public var image: String?
    @NSManaged public var isFavourited: Bool

}

extension Movie : Identifiable {

}
