//
//  secondViewController.swift
//  2017_11_10
//
//  Created by 石田一馬 on 2017/11/24.
//  Copyright © 2017年 HAL. All rights reserved.
//

import UIKit

class secondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    
    @IBOutlet weak var imgbutton: UIButton!
    
    @IBOutlet weak var picker: UIPickerView!
    
    let dataList = [
        "10",
        "20",
        "30",
        "40",
        "50",
        "60"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = UserDefaults.standard
        settings.register(defaults: ["myKey":10])
        // Do any additional setup after loading the view.

        
        picker.delegate = self
        
        picker.dataSource = self
        
        
        
        picker.selectRow(1, inComponent: 0, animated: true)
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    // UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    
    
    @objc(pickerView:titleForRow:forComponent:) func pickerView(_ picker: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        return dataList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int, inComponent component: Int) {
        let settings = UserDefaults.standard
        settings.setValue(dataList[row],
                          forKey: "myKey")
        settings.synchronize()
    }
    
    
    @IBAction func gobuck(_ sender: Any) {
        _=navigationController?.popViewController(animated:
            true)
    }
}
