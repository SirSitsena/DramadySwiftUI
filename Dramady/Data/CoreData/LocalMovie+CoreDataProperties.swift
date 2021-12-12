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

    @NSManaged public var image: String?
    @NSManaged public var isFavourited: Bool
    @NSManaged public var title: String?
    @NSManaged public var titleId: String?
    @NSManaged public var isOnWatchlist: Bool
    @NSManaged public var fullTitle: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var runtimeMins: String?
    @NSManaged public var year: String?
    @NSManaged public var runtimeStr: String?
    @NSManaged public var plot: String?
    @NSManaged public var awards: String?
    @NSManaged public var directors: String?
    @NSManaged public var stars: String?
    @NSManaged public var genres: String?
    @NSManaged public var imDbRating: String?
    @NSManaged public var keywords: String?
    @NSManaged public var tagline: String?

}

extension LocalMovie : Identifiable {

}
