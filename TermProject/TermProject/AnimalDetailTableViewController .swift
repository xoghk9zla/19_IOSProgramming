//
//  AnimalSearchTableViewController.swift
//  TermProject
//
//  Created by KPUGAME on 2019. 6. 1..
//  Copyright © 2019년 KPUGAME. All rights reserved.
//

import UIKit

class AnimalDetailTableViewController: UITableViewController, XMLParserDelegate {
    @IBOutlet var tbData: UITableView!
    
    var url: String?
    
    var parser = XMLParser()
    var posts = NSMutableArray()
    
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var kind = NSMutableString()        // 품종
    var age = NSMutableString()         // 나이
    var happenplace = NSMutableString() // 발견 장소
    
    var imageurl = NSMutableString()
    
    func beginParsing(){
        posts = []
        parser = XMLParser(contentsOf:(URL(string:"http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?bgnde=20140301&endde=20140430&pageNo=1&numOfRows=10&ServiceKey=CJQ9nAHb49w9WHrlkk0MT5t2V69kTMcq4Js5RoW6kTsYJIhX%2FpMWTNueiXNVjNuHwnKoXBQl2FOov8euaabf%2FA%3D%3D"))!)!
        parser.delegate = self
        parser.parse()
        tbData!.reloadData()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String]){
        element = elementName as NSString
        if(elementName as NSString).isEqual(to: "item"){
            elements = NSMutableDictionary()
            elements = [:]
            kind = NSMutableString()
            kind = ""
            age = NSMutableString()
            age = ""
            happenplace = NSMutableString()
            happenplace = ""
            imageurl = NSMutableString()
            imageurl = ""
            
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String){
        if element.isEqual(to: "kindCd"){
            kind.append(string)
        } else if element.isEqual(to: "age"){
            age.append(string)
        } else if element.isEqual(to: "happenPlace"){
            happenplace.append(string)
        } else if element.isEqual(to: "popfile"){
            imageurl.append(string)
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI namespaceURL: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqual(to: "item"){
            if !kind.isEqual(nil) {
                elements.setObject(kind, forKey: "kindCd" as NSCopying)
            }
            if !age.isEqual(nil) {
                elements.setObject(age, forKey: "age" as NSCopying)
            }
            if !happenplace.isEqual(nil) {
                elements.setObject(happenplace, forKey: "happenPlace" as NSCopying)
            }
            if !imageurl.isEqual(nil){
                elements.setObject(imageurl, forKey: "popfile" as NSCopying)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "kindCd") as! NSString as String
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "age") as! NSString as String
        
        if let url = URL(string: (posts.object(at: indexPath.row) as AnyObject).value(forKey: "popfile") as! NSString as String){
            if let data = try? Data(contentsOf: url){
                cell.imageView?.image = UIImage(data: data)
            }
        }

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "segueToMapView"{
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
