//
//  DetailAnimalTableViewController.swift
//  TermProject
//
//  Created by KPUGAME on 2019. 6. 17..
//  Copyright © 2019년 KPUGAME. All rights reserved.
//

import UIKit

class DetailAnimalTableViewController: UITableViewController, XMLParserDelegate{
    @IBOutlet var detailTableView: UITableView!
    
    var url: String?
    var desertionNo: String?
    var parser = XMLParser()
    
    var postsname : [String] = ["품종", "나이", "체중", "색상", "성별", "특징", "발견장소", "접수일", "상태"]
    var posts : [String] = ["", "", "", "", "", "", "", "", ""]
    
    var element = NSString()
    
    var kind = NSMutableString()
    var age = NSMutableString()
    var weight = NSMutableString()
    var color = NSMutableString()
    var sex = NSMutableString()
    var specialmark = NSMutableString()
    var happenplace = NSMutableString()
    var happendate = NSMutableString()
    var state = NSMutableString()
    
    func beginParsing(){
        posts = []
        parser = XMLParser(contentsOf: (URL(string: url!))!)!
        parser.delegate = self
        parser.parse()
        detailTableView!.reloadData()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String]){
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "item"){
            if desertionNo == "desertionNo"{
                
            }
            posts = ["", "", "", "", "", "", "", "", ""]
            kind = NSMutableString()
            kind = ""
            age = NSMutableString()
            age = ""
            weight = NSMutableString()
            weight = ""
            color = NSMutableString()
            color = ""
            sex = NSMutableString()
            sex = ""
            specialmark = NSMutableString()
            specialmark = ""
            happenplace = NSMutableString()
            happenplace = ""
            happendate = NSMutableString()
            happendate = ""
            state = NSMutableString()
            state = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String){
        if element.isEqual(to: "kindCd"){
            kind.append(string)
        } else if element.isEqual(to: "age"){
            age.append(string)
        } else if element.isEqual(to: "weight"){
            weight.append(string)
        } else if element.isEqual(to: "colorCd"){
            color.append(string)
        } else if element.isEqual(to: "sexCd"){
            sex.append(string)
        } else if element.isEqual(to: "specialMark"){
            specialmark.append(string)
        } else if element.isEqual(to: "happenPlace"){
            happenplace.append(string)
        } else if element.isEqual(to: "happenDt"){
            happendate.append(string)
        } else if element.isEqual(to: "processState"){
            state.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI namespaceURL: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqual(to: "item"){
            if !kind.isEqual(nil) {
                posts[0] = kind as String
            }
            if !age.isEqual(nil) {
                posts[1] = age as String
            }
            if !weight.isEqual(nil) {
                posts[2] = weight as String
            }
            if !color.isEqual(nil) {
                posts[3] = color as String
            }
            if !sex.isEqual(nil) {
                posts[4] = sex as String
            }
            if !specialmark.isEqual(nil) {
                posts[5] = specialmark as String
            }
            if !happenplace.isEqual(nil) {
                posts[6] = happenplace as String
            }
            if !happendate.isEqual(nil) {
                posts[7] = happendate as String
            }
            if !state.isEqual(nil) {
                posts[8] = state as String
            }
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
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalCell", for: indexPath)

        cell.textLabel?.text = postsname[indexPath.row]
        cell.detailTextLabel?.text = posts[indexPath.row]

        return cell
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
