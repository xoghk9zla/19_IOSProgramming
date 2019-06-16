//
//  HospitalViewController.swift
//  TermProject
//
//  Created by KPUGAME on 2019. 6. 15..
//  Copyright © 2019년 KPUGAME. All rights reserved.
//

import UIKit

class HospitalViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func doneToPickerViewController(segue: UIStoryboardSegue){
        
    }
    
    var pickerDataSource = ["가평군", "고양시", "과천시", "광명시", "광주시", "구리시", "군포시", "김포시", "남양주시", "동두천시", "부천시", "성남시", "수원시", "시흥시", "안산시", "안성시", "안양시", "양주시", "양평군", "여주시", "연천군", "용인시", "의왕시", "의정부시", "이천시", "파주시", "평택시", "포천시", "하남시", "화성시"]
    
    var url: String = "https://openapi.gg.go.kr/OrganicAnimalProtectionFacilit?KEY=774345bd63264a6fa1e923f279aed9da&pSize=106&SIGUN_CD="
    var sgguCd: String = "41820"
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0{
            sgguCd = "41820"
        } else if row == 1{
            sgguCd = "41280"
        } else if row == 2{
            sgguCd = "41290"
        } else if row == 3{
            sgguCd = "41210"
        } else if row == 4{
            sgguCd = "41610"
        } else if row == 5{
            sgguCd = "41310"
        } else if row == 6{
            sgguCd = "41410"
        } else if row == 7{
            sgguCd = "41570"
        } else if row == 8{
            sgguCd = "41360"
        } else if row == 9{
            sgguCd = "41250"
        } else if row == 10{
            sgguCd = "41190"
        } else if row == 11{
            sgguCd = "41130"
        } else if row == 12{
            sgguCd = "41110"
        } else if row == 13{
            sgguCd = "41390"
        } else if row == 14{
            sgguCd = "41270"
        } else if row == 15{
            sgguCd = "41550"
        } else if row == 16{
            sgguCd = "41170"
        } else if row == 17{
            sgguCd = "41630"
        } else if row == 18{
            sgguCd = "41830"
        } else if row == 19{
            sgguCd = "41730"
        } else if row == 20{
            sgguCd = "41800"
        } else if row == 21{
            sgguCd = "41460"
        } else if row == 22{
            sgguCd = "41430"
        } else if row == 23{
            sgguCd = "41150"
        } else if row == 24{
            sgguCd = "41500"
        } else if row == 25{
            sgguCd = "41480"
        } else if row == 26{
            sgguCd = "41220"
        } else if row == 27{
            sgguCd = "41650"
        } else if row == 28{
            sgguCd = "41450"
        } else{
            sgguCd = "41590"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "segueToHospitalTableView"{
            if let navController = segue.destination as? UINavigationController{
                if let hospitalTableViewController = navController.topViewController as? HospitalTableViewController{
                    hospitalTableViewController.url = url + sgguCd
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
