//
//  SignupViewController.swift
//  Dorm Board
//
//  Created by chansung on 11/14/14.
//  Copyright (c) 2014 chansung. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func swipeAction(sender: UISwipeGestureRecognizer) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func signUpPressed(sender: AnyObject) {
        var error = ""
        
        if usernameField.text == "" || passwordField.text == "" {
            error = "Username or Password is Empty!"
        }
        
        if error != "" {
            
        } else {
            
        }
    }
    
    func displayAlert(title:String, message:String) {
        
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
