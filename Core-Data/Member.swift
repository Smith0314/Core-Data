//
//  Member.swift
//  Core-Data
//
//  Created by Smith on 2015/4/1.
//  Copyright (c) 2015年 Smith-Lab. All rights reserved.
//

import Foundation
import CoreData

@objc(Member)
class Member: NSManagedObject {

    @NSManaged var phone: NSNumber
    @NSManaged var email: String
    @NSManaged var name: String

}
