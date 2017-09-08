//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Ikhsan on 3/8/17.
//  Copyright © 2017 Ikhsan. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    
    
    var restaurants:[Restaurant] = [
        Restaurant(name: "Cafe Deadendkdlskadklaldkad adlkadladkads adlkadas", type: "Coffee & Tea Shop", location: "HongKong", image: "cafedeadend.jpg", isVisited: false),
            Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", image:
                "homei.jpg", isVisited: false),
            Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", image:
                "teakha.jpg", isVisited: false),
            Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location:
                "Hong Kong", image: "cafeloisl.jpg", isVisited: false),
            Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong",
                       image: "petiteoyster.jpg", isVisited: false),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurants.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RestaurantTableViewCell

        cell.nameLabel?.text = restaurants[indexPath.row].name
        cell.thumbnailImage?.image = UIImage(named: restaurants[indexPath.row].image)
        cell.locationLabel?.text = restaurants[indexPath.row].location
            
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let optionMenu = UIAlertController(title: "Alert", message: "What do you want to do?", preferredStyle: .alert)
//        
//        let actionMenu = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        
//        optionMenu.addAction(actionMenu)
//        
//        let callActionHandler = {
//            (action:UIAlertAction!) -> Void in
//                let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet", preferredStyle: .alert)
//            
//                alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            
//                self.present(alertMessage, animated: true, completion: nil)
//        
//        }
//        
//        let callAction = UIAlertAction(title: "Call " + "123-000-\(indexPath.row)", style: .default, handler: callActionHandler)
//        
//        optionMenu.addAction(callAction)
//        
//        present(optionMenu, animated: true, completion: nil)
//    }
 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            restaurants.remove(at: indexPath.row) 
        }
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        //Share
        let shareAction = UITableViewRowAction(style: .default, title: "Share", handler: {
                (action, indexPath) -> Void in
                    let defaultText = "Just checking in at " + self.restaurants[indexPath.row].name
            
                    if let imageToShare = UIImage(named: self.restaurants[indexPath.row].image){
                        let activityViewController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
                        self.present(activityViewController, animated: true, completion: nil)
                    }

            
            }
        )
        
        shareAction.backgroundColor = UIColor(colorLiteralRed: 48.0/255.0, green: 173.0/255.0, blue: 99.0/255.0, alpha: 1.0)
        
        
        //Delete
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: {
                (action, indexPath) -> Void in
                    self.restaurants.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
        })
        return [shareAction, deleteAction]
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "showRestaurantDetail"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationViewController = segue.destination as! RestaurantDetailTableViewController
                destinationViewController.restaurant = restaurants[indexPath.row]
            }
            
        }
        
    }
 

}
