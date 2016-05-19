//
//  InputViewController.swift
//  taskapp
//
//  Created by Masamichi Ebata on 2016/05/16.
//  Copyright © 2016年 Masamichi Ebata. All rights reserved.
//

import UIKit
import RealmSwift

class InputViewController: UIViewController {

   
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!    
    @IBOutlet weak var dataPicker: UIDatePicker!
    
    let realm = try! Realm()
    var task:Task!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(InputViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        titleTextField.text = task.title
        contentsTextView.text = task.contents
        dataPicker.date = task.date
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillDisappear(animated: Bool) {
        try! realm.write {
            self.task.title = self.titleTextField.text!
            self.task.contents = self.contentsTextView.text
            self.task.date = self.dataPicker.date
            self.realm.add(self.task, update: true)
        }
        
        super.viewWillDisappear(animated)
    }
    
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setNotification(task: Task) {
        for notification in UIApplication.sharedApplication().scheduledLocalNotifications! {
            if notification.userInfo!["id"] as! Int == task.id {
                UIApplication.sharedApplication().cancelLocalNotification(notification)
                break
            }
        }
        
        let notification = UILocalNotification()
        
        notification.fireDate = task.date
        notification.timeZone = NSTimeZone.defaultTimeZone()
        notification.alertBody = "\(task.title)"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["id": task.id]
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
    }
}
