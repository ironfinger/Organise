//
//  AddTaskViewController.swift
//  Organise
//
//  Created by Thomas Houghton on 01/02/2018.
//  Copyright © 2018 Thomas Houghton. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // Outlets:
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var colourPickerView: UIPickerView!
    
    // Variables:
    var timetableSlot = TimetableSlot()
    let pickerColours = [
        "Default",
        "Red",
        "Blue",
        "Green",
        "Purple"
    ]
    var colourToSend = 0 // Holds the colour to store into the timetable slot object.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.colourPickerView.dataSource = self
        self.colourPickerView.delegate = self
        
        setupView()
    }
    
    // MARK: View setup.
    func setupView() {
        // Dissmiss Keyboard:
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        self.subView.addGestureRecognizer(UITapGestureRecognizer(target: self.subView, action: #selector(UIView.endEditing(_:))))
        // Sub View:
        subView.layer.cornerRadius = 20
        // Name Text Field:
        nameTextField.layer.cornerRadius = 10
        // Description Text View:
        descriptionTextView.layer.cornerRadius = 10
        
        // Colour Picker View:
        colourPickerView.layer.cornerRadius = 10
        // Next button:
        nextButton.backgroundColor = UIColor.white
        nextButton.layer.cornerRadius = 10
    }
    
    // MARK: PickerView:
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerColours.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerColours[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Selected row \(pickerColours[row])")
        changeColours(selectedColour: row)
    }
    
    func changeColours(selectedColour: Int) {
        UIView.animate(withDuration: 1, delay: 0, options: .allowUserInteraction, animations: {
            self.view.backgroundColor = self.pullColour(selectedColour: selectedColour, shade: 1)
            self.subView.backgroundColor = self.pullColour(selectedColour: selectedColour, shade: 2)
            self.nameTextField.backgroundColor = self.pullColour(selectedColour: selectedColour, shade: 1)
            self.descriptionTextView.backgroundColor = self.pullColour(selectedColour: selectedColour, shade: 1)
            self.colourPickerView.backgroundColor = self.pullColour(selectedColour: selectedColour, shade: 1)
            self.nextButton.tintColor = self.pullColour(selectedColour: selectedColour, shade: 3)
        }) { (true) in
            print("Animation complete")
        }
    }
    
    func pullColour(selectedColour: Int, shade: Int) -> UIColor {
        var returnVal = UIColor()
        let colourPallet = TaskColours()
        
        if (selectedColour == 0) {
            if (shade == 1) {
                returnVal = colourPallet.turquise[0]
            }else if (shade == 2) {
                returnVal = colourPallet.turquise[1]
            }else if (shade == 3) {
                returnVal = colourPallet.turquise[2]
            }
            colourToSend = 0
        }else if (selectedColour == 1) {
            if (shade == 1) {
                returnVal = colourPallet.red[0]
            }else if (shade == 2) {
                returnVal = colourPallet.red[1]
            }else if (shade == 3) {
                returnVal = colourPallet.red[2]
            }
            colourToSend = 1
        }else if (selectedColour == 2) {
            if (shade == 1) {
                returnVal = colourPallet.blue[0]
            }else if (shade == 2) {
                returnVal = colourPallet.blue[1]
            }else if (shade == 3) {
                returnVal = colourPallet.blue[2]
            }
            colourToSend = 2
        }else if (selectedColour == 3) {
            if (shade == 1) {
                returnVal = colourPallet.green[0]
            }else if (shade == 2) {
                returnVal = colourPallet.green[1]
            }else if (shade == 3) {
                returnVal = colourPallet.green[2]
            }
            colourToSend = 3
        }else if (selectedColour == 4) {
            if (shade == 1) {
                returnVal = colourPallet.purple[0]
            }else if (shade == 2) {
                returnVal = colourPallet.purple[1]
            }else if (shade == 3) {
                returnVal = colourPallet.purple[2]
            }
            colourToSend = 4
        }
        return returnVal
    }
    
    // MARK: Actions:
    @IBAction func nextButtonTapped(_ sender: Any) {
        // This is to stop the app from uploading a task without a name.
        if (nameTextField.text == nil || nameTextField.text == "") {
            print("Couldn't move onto next step as the user didn't put in a name for the text")
        }else {
            timetableSlot.name = nameTextField.text!
            if (descriptionTextView.text != nil) {
                timetableSlot.description = descriptionTextView.text!
            }else{
                timetableSlot.description = ""
            }
            timetableSlot.color = pickerColours[colourToSend]
            print("Colour to store \(timetableSlot.color)")
            performSegue(withIdentifier: "AddTaskTimesSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AddTaskTimesSegue") {
            let nextVC = segue.destination as! AddTaskTimesViewController
            nextVC.newTimetableSlot = timetableSlot
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
