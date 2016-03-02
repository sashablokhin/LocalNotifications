//
//  NewItemViewController.swift
//  LocalNotifications
//
//  Created by Alexander Blokhin on 02.03.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import UIKit

class NewItemViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    @IBAction func reminderButtonPressed(sender: AnyObject) {
        let vc = navigationController!.viewControllers[0] as! ViewController
        
        vc.items.addObject(textField.text!)
        vc.tableView.reloadData()
        vc.saveItems()
        
        navigationController!.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
}
