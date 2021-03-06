//
//  TodayViewController.swift
//  doodlebluetask
//
//  Created by apple on 14/12/1942 Saka.
//

import UIKit

class TodayViewController: UIViewController {
    
    //MARK: OUTLET
    @IBOutlet weak var dateLable: UILabel!
    
    //MARK: Variable
    let date = Date()
    let formatter = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //MARK: Current Date
        formatter.dateFormat = "dd / MM / yyyy"
        let result = formatter.string(from: date)
        dateLable.text = result
        
    }
    
    
}
