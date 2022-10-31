//
//  ViewController.swift
//  InClass02
//
//  Created by Carlos Del Carpio on 9/11/21.
//
import UIKit


class HomeViewController: UIViewController {
    @IBOutlet weak var weightTextEdit: UITextField!
    @IBOutlet weak var feetTextEdit: UITextField!
    @IBOutlet weak var inchesTextEdit: UITextField!
    @IBOutlet weak var bmiOutput: UILabel!
    @IBOutlet weak var bmiCategory: UILabel!
    @IBOutlet weak var bmiImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearFields()
    }
    
    
    @IBAction func clearButtonClicked(_ sender: Any) {
        clearFields()
    }
    
    
    @IBAction func calculateButtonClicked(_ sender: Any) {
        let weight = Double(weightTextEdit.text!)
        let feet = Double(feetTextEdit.text!)
        let inches = Double(inchesTextEdit.text!)
        
        
        if let weight = weight {
            if let feet = feet {
                if let inches = inches {
                    let bmi = calculateBMI(weight: weight, feet: feet, inches: inches)
                    bmiOutput.text = "BMI : " + String(format: "%.2f", bmi)
                    
                    
                    switch bmi {
                        case 0..<18.5 :  setBMIDetails(category: "underweight")
                        case 18.5..<25 : setBMIDetails(category: "normal")
                        case 25..<30:    setBMIDetails(category: "overweight")
                        default:         setBMIDetails(category: "obese")
                    }
                } else {
                    showDialog(title: "Error", message: "Enter valid height in inches.")
                }
            } else {
                showDialog(title: "Error", message: "Enter valid height in feet.")
            }
        } else {
            showDialog(title: "Error", message: "Enter valid weight.")
        }
    }
    
    
    func clearFields() {
        weightTextEdit.text = ""
        feetTextEdit.text = ""
        inchesTextEdit.text = ""
        bmiOutput.text = "BMI : 0.00"
        bmiCategory.text = "BMI Category"
        bmiImage.image = nil
    }
    
    
    func calculateBMI(weight: Double, feet: Double, inches: Double) -> Double{
        return (703 * (weight / pow(getHeightInInches(feet: feet, inches: inches), 2)))
    }
    
    
    func getHeightInInches(feet: Double, inches: Double) -> Double{
        return (feet * 12) + inches
    }
    
    
    func setBMIDetails(category: String) {
        bmiImage.image = UIImage(named: category)
        bmiCategory.text = category.capitalized
    }
}


extension UIViewController {
    func showDialog(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
    
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
