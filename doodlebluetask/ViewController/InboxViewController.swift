//
//  InboxViewController.swift
//  doodlebluetask
//
//  Created by apple on 14/12/1942 Saka.
//

import UIKit

class InboxViewController: UIViewController {
    
    //MARK: TableView
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Variable
    var eventTitle: String?
    var evenTime: String?
    var eventDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        eventTitle = UserDefaults.standard.string(forKey: "eventTitle")
        evenTime = UserDefaults.standard.string(forKey: "eventTime")
        eventDate = UserDefaults.standard.string(forKey: "eventDate")
    }
}

//MARK: TableViewDatasource
extension InboxViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! eventTableViewCell
        cell.eventtime.text = evenTime
        cell.eventdate.text = eventDate
        cell.eventtitle.text = eventTitle
        return cell
    }
}
//MARK: TableViewDelegate
extension InboxViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
}
