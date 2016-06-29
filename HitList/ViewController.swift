//
//  ViewController.swift
//  HitList
//
//  Created by Rawnet on 29/06/2016.
//  Copyright © 2016 Rawnet. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
  
  var people = [NSManagedObject]()

  @IBOutlet weak var tableView: UITableView!
  
  
  @IBAction func addButton(sender: AnyObject) {
    
    let alert = UIAlertController(title: "New Name", message: "Add a new Name", preferredStyle: .Alert)
    
    let saveAction = UIAlertAction(title: "Save", style: .Default, handler: { (action:UIAlertAction) -> Void in
      
      let textField = alert.textFields!.first
      self.saveName(textField!.text!)
      self.tableView.reloadData()
    })
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action: UIAlertAction) -> Void in
    }
    
    alert.addTextFieldWithConfigurationHandler {
      (textField: UITextField) -> Void in
    }
    
    alert.addAction(saveAction)
    alert.addAction(cancelAction)
    
    presentViewController(alert, animated: true, completion: nil)
    
  }
  
  func saveName(name: String){
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    let managedContext = appDelegate.managedObjectContext
    
    let entity = NSEntityDescription.entityForName( "Person", inManagedObjectContext: managedContext)
    
    let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
    
    person.setValue(name, forKey: "name")
    
    do {
      try managedContext.save()
      people.append(person)
    } catch let error as NSError {
      print("Could not save \(error), \(error.userInfo)")
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
      title = "\"The List\""
      tableView.registerClass(UITableViewCell.self,forCellReuseIdentifier: "Cell")
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return people.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
    
    let person = people[indexPath.row]
    
    cell!.textLabel!.text = person.valueForKey("name") as? String
    
    return cell!
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

