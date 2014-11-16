//
//  CreateRoomViewController.swift
//  Dorm Board
//
//  Created by PARKCHANSUNG on 11/14/14.
//  Copyright (c) 2014 chansung. All rights reserved.
//

import UIKit

protocol CommunicationBack {
    func afterRoomCreation()
}

class CreateRoomViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var roomNameField: UITextField!
    
    var delegate:CommunicationBack?
    
    func displayAlert(title:String, message:String) {
        var alert:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func swiped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.delegate?.afterRoomCreation()
    }

    @IBAction func addPressed(sender: AnyObject) {
        if roomNameField == "" {
            displayAlert("Creation Fail!", message: "You haven't entered a room name yet!")
        } else {
            var newRoom = PFObject(className: "Room")
            newRoom.setValue(roomNameField.text, forKey: "title")
            newRoom.saveInBackgroundWithBlock({ (succeeded, error) -> Void in
                if succeeded == true {
                    self.displayAlert("Good to Go", message: "You have successfully created a new room")
                } else {
                    println(error)
                }
            })
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        roomNameField.resignFirstResponder()
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
