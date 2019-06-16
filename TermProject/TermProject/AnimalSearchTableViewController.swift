//
//  AnimalSearchTableViewController.swift
//  TermProject
//
//  Created by KPUGAME on 2019. 6. 1..
//  Copyright © 2019년 KPUGAME. All rights reserved.
//

import UIKit

class AnimalSearchTableViewController: UITableViewController, XMLParserDelegate {
    @IBOutlet var tbData: UITableView!
    
    var url: String?
    
    var parser = XMLParser()
    var posts = NSMutableArray()
    
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var kind = NSMutableString()        // 품종
    var age = NSMutableString()         // 나이
    var color = NSMutableString()       // 색상
    var happenplace = NSMutableString() // 발견 장소
    
    var desertionNo = "" // 유기번호
    
    var imageurl = NSMutableString()
    
    var audioController: AudioController
    
    required init?(coder aDecoder: NSCoder) {
        audioController = AudioController()
        audioController.preloadAudioEffects(audioFileNames: AudioEffectFiles)
        
        super.init(coder: aDecoder)
    }
    
    func beginParsing(){
        posts = []
        parser = XMLParser(contentsOf:(URL(string:"http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?bgnde=20140301&endde=20140430&pageNo=1&numOfRows=10&ServiceKey=CJQ9nAHb49w9WHrlkk0MT5t2V69kTMcq4Js5RoW6kTsYJIhX%2FpMWTNueiXNVjNuHwnKoXBQl2FOov8euaabf%2FA%3D%3D"))!)!
        parser.delegate = self
        parser.parse()
        tbData!.reloadData()
        
        audioController.playerEffect(name: SoundWin)
        
        let startX: CGFloat = ScreenWidth - 100
        let startY: CGFloat = 0
        let endY: CGFloat = ScreenHeight + 300
        
        let stars = StardustView(frame: CGRect(x: startX, y: startY, width: 10, height: 10))
        self.view.addSubview(stars)
        self.view.sendSubviewToBack(_: stars)
        
        UIView.animate(withDuration: 3.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut,animations: {stars.center = CGPoint(x: startX, y: endY)}, completion: {(value:Bool) in stars.removeFromSuperview()})
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
            color = NSMutableString()
            color = ""
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
        } else if element.isEqual(to: "colorCd"){
            color.append(string)
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
            if !color.isEqual(nil) {
                elements.setObject(color, forKey: "colorCd" as NSCopying)
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
        
        if segue.identifier == "segueToAnimalDetail"{
            if let cell = sender as? UITableViewCell{
                let indexPath = tableView.indexPath(for: cell)
                //desertionNo = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey:"desertionNo") as! NSString as String
                if let detailAnimalTableViewController = segue.destination as? DetailAnimalTableViewController{
                    //detailAnimalTableViewController.url = url!// + "123" + desertionNo
                }
            }
        }
    }


}
