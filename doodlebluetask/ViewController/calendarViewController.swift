//
//  ViewController.swift
//  doodlebluetask
//
//  Created by apple on 14/12/1942 Saka.
//

import UIKit
import FSCalendar
import EventKit
import UserNotifications

class calendarViewController: UIViewController {
    
    var selectedDate: String?
    var compArray: [Any] = []
    override func viewDidLoad() {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    //MARK: PrepareSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? EventViewController
        vc!.arrComponents = compArray
        vc?.passDate = selectedDate
    }
}

//MARK: FSCalendarDelegate
extension calendarViewController:FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MM-dd-YYYY"
        selectedDate = formatter.string(from: date)
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        compArray = [components.year,components.month,components.day]
        self.performSegue(withIdentifier: "eventVc", sender: self)
    }
}
