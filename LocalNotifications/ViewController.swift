//
//  ViewController.swift
//  LocalNotifications
//
//  Created by Alexander Blokhin on 01.03.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var items = NSMutableArray()

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNotificationSettings() {
        // Specify the notification types.
        let notificationTypes: UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Sound]
        
        var justInformAction = UIMutableUserNotificationAction()
        justInformAction.identifier = "justInform"
        justInformAction.title = "OK, got it"
        justInformAction.activationMode = UIUserNotificationActivationMode.Background
        justInformAction.destructive = false
        justInformAction.authenticationRequired = false
        
        var modifyListAction = UIMutableUserNotificationAction()
        modifyListAction.identifier = "editList"
        modifyListAction.title = "Edit list"
        modifyListAction.activationMode = UIUserNotificationActivationMode.Foreground
        modifyListAction.destructive = false
        modifyListAction.authenticationRequired = true
        
        var trashAction = UIMutableUserNotificationAction()
        trashAction.identifier = "trashAction"
        trashAction.title = "Delete list"
        trashAction.activationMode = UIUserNotificationActivationMode.Background
        trashAction.destructive = true
        trashAction.authenticationRequired = true
    }
    
    func saveItems() {
        let pathsArray = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectory = pathsArray[0] as NSString
        let savePath = documentsDirectory.stringByAppendingPathComponent("items")
        items.writeToFile(savePath, atomically: true)
    }
    
    func loadItems() {
        let pathsArray = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectory = pathsArray[0] as NSString
        let shoppingListPath = documentsDirectory.stringByAppendingPathComponent("items")
        
        if NSFileManager.defaultManager().fileExistsAtPath(shoppingListPath){
            items = NSMutableArray(contentsOfFile: shoppingListPath)!
            tableView.reloadData()
        }
    }

    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = items.objectAtIndex(indexPath.row) as? String
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            items.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            saveItems()
        }
    }

}

