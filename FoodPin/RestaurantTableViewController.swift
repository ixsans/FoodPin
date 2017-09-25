//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Ikhsan on 3/8/17.
//  Copyright © 2017 Ikhsan. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {

    var restaurants:[RestaurantMO] = []
    var searchResults:[RestaurantMO] = []
    var fetchResultController: NSFetchedResultsController<RestaurantMO>!
    var searchController: UISearchController!
    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue){
        if let sourceViewController = segue.source as? AddRestaurantTableViewController {
            //let restaurant = sourceViewController.restaurant
            
            
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "hasViewedWalktrough") {
            return
        }
        
        if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "WalktroughController") as? WalktroughPageViewController{
            present(pageViewController, animated: true, completion: nil)
        }
        
         
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let fetchRequest: NSFetchRequest<RestaurantMO> = RestaurantMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let context = appDelegate.persistentContainer.viewContext
            
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do{
                try fetchResultController.performFetch()
                if let fetchObjects = fetchResultController.fetchedObjects{
                    restaurants = fetchObjects
                }
            }catch{
                print(error)
            }
        }
        
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.placeholder = "Search restaurants..."
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor(red: 218.0/255.0, green: 100.0/255.0, blue: 70.0/255.0, alpha: 1.0)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
    
    func filterContent(for searchText: String){
        
        searchResults = restaurants.filter({
            (restaurant) -> Bool in
            if searchText == "" {
             return true
            }
            
            if let name = restaurant.name{
                return name.localizedCaseInsensitiveContains(searchText)
            }
            
            return false
        })
    }
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath{
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath{
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath{
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        
        if let fetchObjects = controller.fetchedObjects{
            restaurants = fetchObjects as! [RestaurantMO]
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
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
        if searchController.isActive{
            return searchResults.count
        }else{
            return restaurants.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RestaurantTableViewCell
        let restaurant = searchController.isActive ? searchResults[indexPath.row] : restaurants[indexPath.row]
        
        cell.nameLabel?.text = restaurant.name
        cell.thumbnailImage?.image = UIImage(data: restaurant.image as! Data)
        cell.locationLabel?.text = restaurant.location
        cell.accessoryType = restaurant.isVisited ? .checkmark : .none
            
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
                    let defaultText = "Just checking in at " + self.restaurants[indexPath.row].name!
            
                    if let imageToShare = UIImage(data: self.restaurants[indexPath.row].image as! Data){
                        let activityViewController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
                        self.present(activityViewController, animated: true, completion: nil)
                    }

            
            }
        )
        
        shareAction.backgroundColor = UIColor(colorLiteralRed: 48.0/255.0, green: 173.0/255.0, blue: 99.0/255.0, alpha: 1.0)
        
        
        //Delete
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: {
                (action, indexPath) -> Void in
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
                let context = appDelegate.persistentContainer.viewContext
                let restaurantToDelete = self.fetchResultController.object(at: indexPath)
                context.delete(restaurantToDelete)
                
                appDelegate.saveContext()
            }
            
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
                destinationViewController.restaurant = searchController.isActive ? searchResults[indexPath.row] : restaurants[indexPath.row]
            }
            
        }
        
    }
    
    
 

}
