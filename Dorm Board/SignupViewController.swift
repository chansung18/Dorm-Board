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
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    func displayAlert(title:String, message:String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.layer.cornerRadius = 5
        activityIndicator.layer.masksToBounds = true
        activityIndicator.backgroundColor = UIColor.grayColor()
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.White
        self.view.addSubview(activityIndicator)
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
            displayAlert("Not Enough Info", message: error)
        } else {
            var user = PFUser()
            user.username = usernameField.text
            user.password = passwordField.text
            
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            user.signUpInBackgroundWithBlock(){ (succeeded, signUpError) -> Void in
                
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                if succeeded == true {
                    self.dismissViewControllerAnimated(true, completion: { () -> Void in
                        
                        println("asdfasdfasdfasdfasdf")
                        isSignedUp = true
                        defaultUsername = self.usernameField.text
                        defaultPassword = self.passwordField.text
                    })
                } else {
                    if let errorString = signUpError.userInfo?["error"] as? NSString {
                        self.displayAlert("Sign Up Fail", message: errorString)
                    }
                }
            }
        }
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
