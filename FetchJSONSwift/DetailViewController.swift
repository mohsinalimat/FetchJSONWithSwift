//
//  DetailViewController.swift
//  FetchJSONSwift
//
//  Created by Lucas on 1/10/17.
//  Copyright © 2017 Lucas. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var labelId: UILabel!
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelActive: UILabel!
    
    var person: Person!
    var tickets = [Ticket]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getUserTickets(person: person)
        setupUserInfoView(person: person)
    }
    
    func setupUserInfoView(person: Person) {
        //Load user info onto the view
        labelId.text = String(person.id)
        labelUsername.text = person.lastName + ", " + person.firstName
        if !person.active {
            labelActive.text = "Dismissed."
            labelActive.textColor = UIColor.red
        } else {
            labelActive.text = "Active"
        }
        
    }
    
    func getUserTickets(person: Person) {
        //Iterate over user tickets for our list
        for ticket in person.ticket {
            tickets.append(ticket)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = tickets[indexPath.row].title
        cell.detailTextLabel?.text = tickets[indexPath.row].ticketDesc
        
        return cell
    }

}
