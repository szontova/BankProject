//
//  Constants.swift
//  Free Bank
//
//  Created by Sasha Zontova on 4/27/21.
//

import CoreData
import UIKit

struct CoreDataConstants {
    static let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static let db = CoreDataViewController()
}

struct BaseVCConstants {
    static let base = BaseViewController()
}
