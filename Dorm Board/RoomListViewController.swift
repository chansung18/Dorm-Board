//
//  RoomListViewController.swift
//  Dorm Board
//
//  Created by PARKCHANSUNG on 11/14/14.
//  Copyright (c) 2014 chansung. All rights reserved.
//

import UIKit

class RoomListViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var roomTableView: UITableView!
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    var isRefreshing = true
    var listOfRoom = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.layer.cornerRadius = 5
        activityIndicator.layer.masksToBounds = true
        activityIndicator.backgroundColor = UIColor.grayColor()
        activityIndicator.hidesWhenStopped = true
        
        self.view.addSubview(activityIndicator)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        var query = PFQuery(className: "Room")
        
        if isRefreshing == true {
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                self.isRefreshing = false
                
                if error == nil {
                    self.listOfRoom = objects
                    self.roomTableView.reloadData()
                } else {
                    println(error)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfRoom.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Room Cell") as UITableViewCell
        
        var room = self.listOfRoom[indexPath.row] as PFObject
        
        cell.textLabel.text = room.valueForKey("title") as? String
        
        return cell
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
