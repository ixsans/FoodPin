//
//  AddRestaurantTableViewController.swift
//  FoodPin
//
//  Created by Ikhsan on 11/9/17.
//  Copyright © 2017 Ikhsan. All rights reserved.
//

import UIKit

class AddRestaurantTableViewController: UITableViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var restaurantNameField: UITextField!
    @IBOutlet var restaurantTypeField: UITextField!
    @IBOutlet var phoneNumberField: UITextField!
    @IBOutlet var restaurantLocationField: UITextField!
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var noBUtton: UIButton!
    
    var isVisited = false
    var restaurant: RestaurantMO!
    
    
    @IBAction func toggleBeenHere(sender: UIButton){
        if sender == yesButton{
            isVisited = true
            yesButton.backgroundColor = UIColor.red
            noBUtton.backgroundColor = UIColor.gray
        }else if sender == noBUtton{
            isVisited = false
            yesButton.backgroundColor = UIColor.gray
            noBUtton.backgroundColor = UIColor.red
        }
    }
    
    @IBAction func btnSaveClicked(sender: UIButton!){
        if restaurantNameField.text == "" || restaurantLocationField.text == "" || restaurantTypeField.text == ""{
            let alert = UIAlertController(title: "Alert",
                                          message: "Please complete all fields",
                                          preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }else{
            print(restaurantNameField.text!)
            print(restaurantTypeField.text!)
            print(restaurantLocationField.text!)
            print(phoneNumberField.text!)
            print("is visited: \(isVisited)")
            
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
                restaurant = RestaurantMO(context: appDelegate.persistentContainer.viewContext)
                restaurant.name = restaurantNameField.text
                restaurant.type = restaurantTypeField.text
                restaurant.location = restaurantLocationField.text
                restaurant.isVisited = isVisited
                restaurant.phone = phoneNumberField.text
                
                if let restaurantImage = photoImageView.image{
                    if let imageData = UIImagePNGRepresentation(restaurantImage){
                        restaurant.image = NSData(data: imageData)
                    }
                }
                
                print("Save data to context...")
                appDelegate.saveContext()
            }
            
            performSegue(withIdentifier: "unwindToHomeScreen", sender: self)
        }
    }

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

   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                
                present(imagePicker, animated: true, completion: nil)
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
        
        let leadingConstraint = NSLayoutConstraint(item: photoImageView, attribute:
            NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem:
            photoImageView.superview, attribute: NSLayoutAttribute.leading, multiplier: 1,
                                      constant: 0)
        leadingConstraint.isActive = true
        let trailingConstraint = NSLayoutConstraint(item: photoImageView,attribute:NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal,
                                                    toItem: photoImageView.superview, attribute: NSLayoutAttribute.trailing,
                                                    multiplier: 1, constant: 0)
        trailingConstraint.isActive = true
        let topConstraint = NSLayoutConstraint(item: photoImageView, attribute:
            NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem:
            photoImageView.superview, attribute: NSLayoutAttribute.top, multiplier: 1,
                                      constant: 0)
        topConstraint.isActive = true
        let bottomConstraint = NSLayoutConstraint(item: photoImageView, attribute:
            NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem:
            photoImageView.superview, attribute: NSLayoutAttribute.bottom, multiplier: 1,
                                      constant: 0)
        bottomConstraint.isActive = true
        
        dismiss(animated: true, completion: nil)
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
