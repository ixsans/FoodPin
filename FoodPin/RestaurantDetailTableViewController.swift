//
//  RestaurantDetailTableViewController.swift
//  FoodPin
//
//  Created by Ikhsan on 29/8/17.
//  Copyright © 2017 Ikhsan. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailTableViewController:  UIViewController, UITableViewDataSource,
UITableViewDelegate {

    @IBOutlet var restaurantImageView:UIImageView!
    @IBOutlet var tableView:UITableView!
    @IBOutlet var mapView:MKMapView!

    @IBAction func close(segue:UIStoryboardSegue){
        
    }
    
   
    var restaurant:RestaurantMO!
    //var fieldNameLabel = ["Name", "Location", "Type"]
    
    
    @IBAction func ratingButtonTapped(segue: UIStoryboardSegue){
        if let rating = segue.identifier{
            restaurant.isVisited = true
            
            switch rating {
                case "great":
                    restaurant.rating = "Absolutely love it! Must try."
                case "good":
                    restaurant.rating = "Prety good."
                case "dislike":
                    restaurant.rating = "I don't like it"
                default:
                    break
            }
            
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
                appDelegate.saveContext()
            }
            
            tableView.reloadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        tableView.estimatedRowHeight = 66.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        restaurantImageView.image = UIImage(data: restaurant.image as! Data)
        
        //create tap recognizer with action = showMap
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showMap))
        //use regognizer for map touch action
        mapView.addGestureRecognizer(tapGestureRecognizer)
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString("524 Ct St, Brooklyn, NY 11231", completionHandler: {
            placemarks, error in
            if error != nil{
                print(error!)
                return
            }
            
            if let placemarks = placemarks {
                // Get the first placemark
                let placemark = placemarks[0]
                // Add annotation
                let annotation = MKPointAnnotation()
                if let location = placemark.location {
                    // Display the annotation
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)
                    // Set the zoom level
                    let region =
                        MKCoordinateRegionMakeWithDistance(annotation.coordinate, 250, 250)
                    self.mapView.setRegion(region, animated: false)
                }
            }
        })
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap"{
            let destinationViewController = segue.destination as! MapViewController
            destinationViewController.restaurant = restaurant
        }
        
    }
    
    func showMap(){
        performSegue(withIdentifier: "showMap", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RestaurantDetailViewCellTableViewCell

        // Configure the cell...
        switch indexPath.row {
        case 0:
            cell.fieldLabelView.text = "Name"
            cell.valueLabelView.text = restaurant.name
        case 1:
            cell.fieldLabelView.text = "Type"
            cell.valueLabelView.text = restaurant.type
        case 2:
            cell.fieldLabelView.text = "Location"
            cell.valueLabelView.text = restaurant.location
        case 3:
            cell.fieldLabelView.text = "Been here"
            cell.valueLabelView.text = (restaurant.isVisited) ? "Yes, I've been here before. \(restaurant.rating)" : "No"
        default:
            cell.fieldLabelView.text = ""
            cell.valueLabelView.text = ""
        }
        

        return cell
    }
    
 
}
