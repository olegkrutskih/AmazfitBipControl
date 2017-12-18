//
//  MessagingViewController.swift
//  AmazfitBipControl
//
//  Created by Круцких Олег on 18.12.2017.
//  Copyright © 2017 Круцких Олег. All rights reserved.
//

import UIKit

class MessagingViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var data: [String] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if self.data.count > row {
            self.messageField!.text = self.data[row]
            self.view.endEditing(true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage()
        return true
    }

    
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var messagePickerList: UIPickerView!
    
    @IBAction func clearHistory() {
        appDelegate.clearMessages(callback: reloadHistory)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageField!.delegate = self
        self.messagePickerList!.delegate = self
        reloadHistory()
        if self.data.count > 0 {
            self.messagePickerList!.selectRow(0, inComponent: 0, animated: true)
            self.messageField!.text = self.data[0]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendMessage() {
        if self.messageField!.text != "" {
            self.appDelegate.addMessages(id: self.data.count, message: self.messageField!.text!)
            self.appDelegate.refreshMessages(callback: reloadHistory)
            self.messageField!.text = ""
            self.view.endEditing(true)
        }
    }
    
    func reloadHistory(){
        self.data.removeAll()
        for item in appDelegate.messagesArray {
            self.data.insert(item, at: 0)
        }
        //self.data = appDelegate.messagesArray
        self.messagePickerList!.dataSource = self
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
