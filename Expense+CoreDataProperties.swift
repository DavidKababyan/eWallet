//
//  Expense+CoreDataProperties.swift
//  eWallet
//
//  Created by David Kababyan on 01/11/2015.
//  Copyright © 2015 David Kababyan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Expense {

    @NSManaged var amount: NSNumber?
    @NSManaged var date: NSDate?
    @NSManaged var dateString: String?
    @NSManaged var isExpense: NSNumber?
    @NSManaged var monthOfTheYear: NSNumber?
    @NSManaged var weekOfTheYear: NSNumber?
    @NSManaged var year: NSNumber?
    @NSManaged var name: String?

}
