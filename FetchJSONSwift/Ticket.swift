//
//  Ticket.swift
//  FetchJSONSwift
//
//  Created by Lucas on 1/10/17.
//  Copyright © 2017 Lucas. All rights reserved.
//

import UIKit
import RealmSwift

class Ticket: Object {
    dynamic var id = 0
    dynamic var title = ""
    dynamic var ticketDesc = ""
}
