//
//  EventViewController.swift
//  doodlebluetask
//
//  Created by apple on 14/12/1942 Saka.
//

import UIKit
import FSCalendar
import EventKit
import UserNotifications

class EventViewController: UIViewController {

    //MARK: OUTLET
    @IBOutlet weak var setTimeLabel: UILabel!
    @IBOutlet weak var datepicker: UIDatePicker!
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var eventTextfield: UITextField!
    @IBOutlet weak var before1hour: UIButton!
    @IBOutlet weak var before10mins: UIButton!

    //MARK: variable
    var passDate: String?
    var eventBody: String?
    var hour: Int = 0
    var min: Int = 0
    var arrComponents: [Any]?
    var alert: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem?.tintColor = .red
        scheduleLabel.text = passDate
        datepicker.datePickerMode = .time
        datepicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }

    //MARK: Date Picker
    @objc func dateChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([ .hour, .minute], from: datepicker.date)
        if let hours = components.hour, let minutes = components.minute {
            if alert == false {
                hour = hours - 1
                min = minutes
            }else {
                if minutes < 10 {
                    hour = hours - 1
                    let minute = minutes - 10
                    min = 60 + minute
                }
                else { hour = hours
                    min = minutes - 10
                }
            }
        }
    }

    //MARK: Save Event Details
    @IBAction func okButtonAction(_ sender: Any) {
        if eventTextfield.text == ""{
            showAlert(title: Constants.ERROR_INFO, message: Constants.EVENT_TITLE)
        }
        else if before10mins.isSelected == false && before1hour.isSelected == false {
            showAlert(title: Constants.ERROR_INFO, message: Constants.EVENT_ALERT)
        }
        else if hour == 0 && min == 0 {
            showAlert(title: Constants.ERROR_INFO, message: Constants.EVENT_REMIND)
        }
        
        eventLabel.text = eventTextfield.text
        eventBody = eventLabel.text
        setTimeLabel.text = String(hour) + ":" + String(min)
        UserDefaults.standard.set(eventLabel.text, forKey: "eventTitle")
        UserDefaults.standard.set(setTimeLabel.text, forKey: "eventTime")
        UserDefaults.standard.set(passDate, forKey: "eventDate")
        showAlert(title: Constants.ERROR_GREETINGS, message: Constants.EVENT_DATASAVED)
        schedule()
    }


    //MARK: local Notification 
    func schedule(){
        
        let date = DateComponents(year: (arrComponents![0] as? Int),
                                  month: arrComponents![1] as? Int,
                                  day: arrComponents![2] as? Int,
                                  hour: hour,
                                  minute: min)
        
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Event!", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: eventBody!, arguments: nil)
        content.sound = UNNotificationSound.default
        content.badge = 1

        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        
        let request = UNNotificationRequest(identifier: "first", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request){ (error: Error?) in
            if let theError = error {
                print(theError)
            }
            
        }
    }

    //MARK: Alert Type
    @IBAction func alertSelection(sender: UIButton){
        if sender.tag == 2 {
            alert = true
            before10mins.isSelected = true
            before1hour.isSelected = false
            
        }
        else if sender.tag == 1 {
            alert = false
            before10mins.isSelected = false
            before1hour.isSelected = true
            
        }
    }
}

//MARK: AlertController
extension EventViewController {
    func showAlert(title: String,message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
