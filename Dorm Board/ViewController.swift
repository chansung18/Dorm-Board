//
//  ViewController.swift
//  Dorm Board
//
//  Created by chansung on 11/14/14.
//  Copyright (c) 2014 chansung. All rights reserved.
//

import UIKit

var defaultUsername = ""
var defaultPassword = ""
var isSignedUp = false

class ViewController: UIViewController {

    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logInPressed(sender: AnyObject) {
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        PFUser.logInWithUsernameInBackground(usernameField.text, password: passwordField.text) { (user, error) -> Void in
            
            self.activityIndicator.stopAnimating()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            
            if error == nil {
                self.performSegueWithIdentifier("login complete", sender:self)
            } else {
                let errorMessage = error.userInfo?["error"] as? NSString
                var alert = UIAlertController(title: "Login Failed!", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                    alert.dismissViewControllerAnimated(true, completion: nil)
                }))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
}

