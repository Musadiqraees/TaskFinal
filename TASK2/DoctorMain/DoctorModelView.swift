//
//  DoctorViewModel.swift
//  TASK2
//
//  Created by Macbook on 1/20/18.
//  Copyright © 2018 Macbook. All rights reserved.
//

import Foundation
import Alamofire

protocol DoctorDelegate
{
    func getDoctorDataFromApi(error:Error?) -> ()
}

class DoctorModelView:NSObject
{
    var delegate : DoctorDelegate?
    var doctorsArray  = [JSON]()
    var LastKey: String? = ""
    var cache:NSCache<AnyObject, AnyObject>!  = NSCache()
    
    ////////// res
    func reIntializer() -> ()
    {
        self.LastKey = ""
        self.doctorsArray = []
        self.cache = NSCache()
    }
    
    func getDoctorListWithText(text:String) -> ()
    {
        guard self.LastKey != nil else {
            self.delegate?.getDoctorDataFromApi(error: nil)
            return
    }
        
        let parameter: JSONDictionary=["searchText":text,"LastKey":self.LastKey ?? ""]
        
        WebService().getDoctor(parameters:parameter , onCompletion: { (json, error) in
            
            //JSON(json["content"].arrayObject! + json["content"].arrayObject!)
            self.doctorsArray =  self.doctorsArray + json["doctors"].arrayValue
            self.LastKey = json["lastKey"].string
            print(json["lastKey"])
            ////////calling delegate
            self.delegate?.getDoctorDataFromApi(error: error)
        })
    }
    
    func numberOfRowsInTableView(section:Int) -> (Int)
    {
        return  doctorsArray.count
        
    }
    
    func cellforRowAtIndexPath(tableView: UITableView,cell:DoctorTableViewCell,indexPath: IndexPath) -> DoctorTableViewCell
    {
        let jsonObj = doctorsArray[indexPath.row]
       cell.nameLbl.text=jsonObj["name"].string
        cell.doctorAdressLbl.text=jsonObj["address"].string
        cell.imageViewDoctor.image = UIImage(named: "stethoscope")
        if let photoId = jsonObj["photoId"].string
        {
            if (self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) != nil){
                // 2
                // Use cache
                print("Cached image used, no need to download it")
                cell.imageViewDoctor?.image = self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) as? UIImage
                
            }
            else
            {
            let url = URL(string: "https://api.uvita.eu/api/users/me/files/\(photoId)")
            let headers: HTTPHeaders = [ "Authorization":"\(SharedManager.sharedInstance.getApiToken())","Accept":"image/jpeg"]
            Alamofire.request(url!, headers: headers).responseData { response in
                if let imageData = response.result.value {
                DispatchQueue.main.async(execute: { () -> Void in
                        // 5
                        // Before we assign the image, check whether the current cell is visible
                    if let updateCell:DoctorTableViewCell = tableView.cellForRow(at: indexPath) as? DoctorTableViewCell {
                            let image : UIImage = UIImage(data: imageData)!
                            updateCell.imageViewDoctor.image = image
                            self.cache.setObject(image, forKey: (indexPath as NSIndexPath).row as AnyObject)
                        }
                    })
                }
            }
            }
        
        }
        return cell
    }
    
}

