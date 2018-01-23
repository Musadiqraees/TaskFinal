//
//  DoctorViewController.swift
//  TASK2
//
//  Created by Macbook on 1/20/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import UIKit
import CoreLocation
 

class DoctorViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,DoctorDelegate,CLLocationManagerDelegate
{
    
    @IBOutlet var doctModelView: DoctorModelView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        doctModelView.delegate=self
        searchBar.delegate = self
        ///////getting location
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        /////calling website

        self.definesPresentationContext = true

    }

    
    ///////////delegate for reciving data from api
    func getDoctorDataFromApi(error: Error?)
    {
        tableView.reloadData()
        MBProgressHUD.hide(for: self.view, animated: true)
        
    }
    ////////call web api
    
    func requestWebApi(text:String) -> ()
    {
        MBProgressHUD.showAdded(to: self.view, animated: true)
     doctModelView.getDoctorListWithText(text: text)
        
    }
    /////tableView delegates methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  doctModelView.numberOfRowsInTableView(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    self.tableView=tableView
    let cell = tableView.dequeueReusableCell(
        withIdentifier: "DoctorCell",
        for: indexPath) as! DoctorTableViewCell
        
    return doctModelView.cellforRowAtIndexPath(tableView:self.tableView, cell: cell, indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //Bottom Refresh
        
        if scrollView == tableView{
            
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                        //isNewDataLoading = true
                requestWebApi(text: self.searchBar.text!)
               
            }
        }
    }
    
    //////////// Search Bar
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //searchActive = true;
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        //searchActive = false;
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       // searchActive = false;
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
       
        doctModelView.reIntializer()
        requestWebApi(text: searchBar.text!)
    }
    
    func searchBar(_ searchBar: UISearchBar,
                            textDidChange searchText: String){
        
   // requestWebApi(text: searchText)
    }
    
    /////////////Location
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let locValue:CLLocationCoordinate2D = (manager.location?.coordinate)!
        
        SharedManager.sharedInstance.setLocation(location:locValue)
        
        requestWebApi(text:"")
        
        manager.stopUpdatingLocation()
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
        
        requestWebApi(text:"")
    }
    
}
