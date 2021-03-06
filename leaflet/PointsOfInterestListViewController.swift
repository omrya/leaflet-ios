//
//  PointsOfInterestListViewController.swift
//  leaflet
//
//  Created by Cindy Zeng on 4/8/15.
//  Copyright (c) 2015 parks-and-rec. All rights reserved.
//

import UIKit

class PointsOfInterestListViewController: UITableViewController, ENSideMenuDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    private var allPois = [FecPoi]()
    var selectedPoi: FecPoi!
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("pointOfInterest") as? PointsOfInterestListViewCell ?? PointsOfInterestListViewCell()
        var pointOfInterest = self.allPois[indexPath.row]
        
        cell.poiName.text = pointOfInterest.title
        cell.locationAway.text = pointOfInterest.getHumanDistance()
        
        cell.poiImage.image = pointOfInterest.image
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allPois.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedPoi = allPois[indexPath.row]
        
        self.performSegueWithIdentifier("toContentFromList", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: GlobalConstants.defaultNavColor)
        self.tableView.rowHeight = 60.0
        
        allPois = LibraryAPI.sharedInstance.getPois()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: GlobalConstants.defaultNavColor)
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.clipsToBounds = false
        self.sideMenuController()?.sideMenu?.delegate = self
        hideSideMenuView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func revealCompassView(sender: AnyObject) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("compassView") as! UIViewController
        sideMenuController()?.setContentViewController(destViewController)
    }
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
            case "toContentFromList":
                if var poiVC = segue.destinationViewController as? DetailedViewController {
                    poiVC.selectedPoi = self.selectedPoi
                }
            default:
                break
        }
        
    }
    
}
