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
    
    var pickerDataSource = ["가평군", "고양시", "과천시", "광명시", "광주시", "구리시", "군포시", "김포시", "남양주시", "동두천시", "부천시", "성남시", "수원시", "시흥시", "안산시", "안성시", "안양시", "양주시", "양평군", "연천군", "용인시", "의왕시", "의정부시", "이천시", "파주시", "평택시", "포천시", "하남시", "화성시"]
    
    var url: String = "https://openapi.gg.go.kr/OrganicAnimalProtectionFacilit?KEY=774345bd63264a6fa1e923f279aed9da&SIGUN_CD="
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
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "segueToHospitalTableView"{
            if let navController = segue.destination as? UINavigationController{
                if let hospitalTableViewController = navController.topViewController as? HospitalViewController{
                    //hospitalTableViewController.url = url + sgguCd
                    print(hospitalTableViewController.url)
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
