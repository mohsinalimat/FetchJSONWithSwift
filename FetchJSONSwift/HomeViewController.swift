//
//  HomeViewController.swift
//  FetchJSONSwift
//
//  Created by Lucas on 1/10/17.
//  Copyright © 2017 Lucas. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift

class HomeViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var json: JSON = JSON.null
    var persons: Results<Person>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        persons = realm.objects(Person.self)
        
        //Clean realm
        try! realm.write {
            realm.deleteAll()
        }
        
        //Load json file from project
        loadFromFile(type: "json", name: "company")
    }
    
    func loadFromFile(type: String, name: String) {
        //Load desired file
        if let file = Bundle.main.path(forResource: name, ofType: type) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: file))
                json = JSON(data: data)
                switch self.json.type {
                case .dictionary:
                    //Browse through the json file for our desire info (in this case - people in support)
                    if let support = json["company"]["support"].array {
                        try! realm.write {
                            //Iterate over the people in our json file
                            for people in support {
                                //Create person object and assign values
                                let person = Person()
                                person.id = people["id"].int!
                                person.firstName = people["first_name"].string!
                                person.lastName = people["last_name"].string!
                                person.active = people["active"].bool!
                                //If this person has tickets asigned to them, Iterate them
                                if let tickets = people["tickets"].array {
                                    for ticket in tickets {
                                        //Create ticket and assign values
                                        let userTicket = Ticket()
                                        userTicket.id = ticket["id"].int!
                                        userTicket.title = ticket["title"].string!
                                        userTicket.ticketDesc = ticket["problem"].string!
                                        //Save ticket to realm
                                        realm.add(userTicket)
                                        //Asign ticket to user
                                        person.ticket.append(userTicket)
                                    }
                                }
                                //Save user to realm
                                realm.add(person)
                            }
                        }
                    }
                default:
                    print("Do nothing")
                }
            } catch {
                print("Error loading persons.")
            }
        }
        //Reload table data
        self.tableView.reloadData()
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = persons?[indexPath.row].firstName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Prepare our detail view
        if let dc = storyboard?.instantiateViewController(withIdentifier: "DetailView") as? DetailViewController {
            //Asign selected user to detailview.person
            dc.person = persons[indexPath.row]
            //Push the view
            navigationController?.pushViewController(dc, animated: true)
        }
    }

}
