//
//  ViewController.swift
//  TermProject
//
//  Created by KPUGAME on 2019. 6. 1..
//  Copyright © 2019년 KPUGAME. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func doneToPickerViewController(segue: UIStoryboardSegue){
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "segueToTableView"{
            if let navController = segue.destination as? UINavigationController{
                if let animalsearchTableViewController = navController.topViewController as? AnimalSearchTableViewController{
                    print("")
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

