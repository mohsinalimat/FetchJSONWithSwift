//
//  Person.swift
//  FetchJSONSwift
//
//  Created by Lucas on 1/10/17.
//  Copyright © 2017 Lucas. All rights reserved.
//

import UIKit
import RealmSwift

class Person: Object {
    dynamic var id = 0
    dynamic var firstName = ""
    dynamic var lastName = ""
    dynamic var active = false
    let ticket = List<Ticket>()
}
