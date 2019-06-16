//
//  HospitalTableViewController.swift
//  TermProject
//
//  Created by KPUGAME on 2019. 6. 15..
//  Copyright © 2019년 KPUGAME. All rights reserved.
//

import UIKit

class HospitalTableViewController: UITableViewController, XMLParserDelegate {
    @IBOutlet var tbData: UITableView!
    
    var url: String?
    
    var parser = XMLParser()
    var posts = NSMutableArray()
    
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var hospitalName = NSMutableString()
    var addr = NSMutableString()
    
    var XPos = NSMutableString()
    var YPos = NSMutableString()
    
    func beginParsing(){
        posts = []
        parser = XMLParser(contentsOf:(URL(string:url!))!)!
        parser.delegate = self
        parser.parse()
        tbData!.reloadData()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String]){
        element = elementName as NSString
        if(elementName as NSString).isEqual(to: "row"){
            elements = NSMutableDictionary()
            elements = [:]
            hospitalName = NSMutableString()
            hospitalName = ""
            addr = NSMutableString()
            addr = ""
            XPos = NSMutableString()
            XPos = ""
            YPos = NSMutableString()
            YPos = ""
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String){
        if element.isEqual(to: "ENTRPS_NM"){
            hospitalName.append(string)
        } else if element.isEqual(to: "REFINE_ROADNM_ADDR"){
            addr.append(string)
        } else if element.isEqual(to: "REFINE_WGS84_LOGT"){
            XPos.append(string)
        } else if element.isEqual(to: "REFINE_WGS84_LAT"){
            YPos.append(string)
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI namespaceURL: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqual(to: "row"){
            if !hospitalName.isEqual(nil) {
                elements.setObject(hospitalName, forKey: "ENTRPS_NM" as NSCopying)
            }
            if !addr.isEqual(nil) {
                elements.setObject(addr, forKey: "REFINE_ROADNM_ADDR" as NSCopying)
            }
            if !XPos.isEqual(nil) {
                elements.setObject(XPos, forKey: "REFINE_WGS84_LOGT" as NSCopying)
            }
            if !YPos.isEqual(nil) {
                elements.setObject(YPos, forKey: "REFINE_WGS84_LAT" as NSCopying)
            }
            posts.add(elements)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        beginParsing()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HospitalCell", for: indexPath)
        
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "ENTRPS_NM") as! NSString as String
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "REFINE_ROADNM_ADDR") as! NSString as String

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "segueToHospitalMapView"{
            if let mapViewController = segue.destination as? AnimalMapViewController{
                mapViewController.posts = posts
            }
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
