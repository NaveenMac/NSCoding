//
//  UserViewController.swift
//  Register
//
//  Created by Naveen on 20/07/16.
//  Copyright © 2016 naveen. All rights reserved.
//

import UIKit

class UserViewController: UITableViewController {

    var users = [User]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        navigationItem.leftBarButtonItem = editButtonItem()
      
      
      if let savedUsers = loadUsers(){
        users += savedUsers
      }else{
        loadSampleUsers()
      }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
  
  func  loadSampleUsers(){
      let photo1 = UIImage(named: "meal1")
      let user1 = User(name: "Naveen", photo: photo1)!
    
      let photo2 = UIImage(named: "meal2")
      let user2 = User(name: "Aashish", photo: photo2)!
    
      users += [user1, user2]
  }

  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
      let cellIdentifier = "UserTableViewCell"
      
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! UserTableViewCell

        // Configure the cell...
      let user = users[indexPath.row]
      
      cell.name.text = user.name
      cell.photo.image = user.photo

        return cell
    }
    

  
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
  

  
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
          users.removeAtIndex(indexPath.row)
          saveUsers()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
  
  
  @IBAction func unwindToUserList(sender: UIStoryboardSegue) {
    if let sourceViewController = sender.sourceViewController as? UserDetailViewController, user = sourceViewController.user {
      if let selectedIndexPath = tableView.indexPathForSelectedRow {
        // Update an existing meal.
        users[selectedIndexPath.row] = user
        tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
      } else {
        // Add a new meal.
        let newIndexPath = NSIndexPath(forRow: users.count, inSection: 0)
        users.append(user)
        tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
      }
      // Save the meals.
      saveUsers()
    }
  }
  
  

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
      
      if segue.identifier == "ShowDetail"{
          let userDetailViewController = segue.destinationViewController as! UserDetailViewController
        
        if let selectedUserCell = sender as? UserTableViewCell{
          let indexPath = tableView.indexPathForCell(selectedUserCell)!
          let selectedUser = users[indexPath.row]
          
          userDetailViewController.user = selectedUser
          
        }
      }else if segue.identifier == "AddNewUser"{
        print("Add new user")
      }
      
    }
  
  func saveUsers(){
    let isSuccessfullSave = NSKeyedArchiver.archiveRootObject(users, toFile: User.ArchiveURL.path!)
    if !isSuccessfullSave{
      print("Failed to save users")
    }
  }
  
  func  loadUsers() -> [User]?{
    return NSKeyedUnarchiver.unarchiveObjectWithFile(User.ArchiveURL.path!) as? [User]
  }
}
