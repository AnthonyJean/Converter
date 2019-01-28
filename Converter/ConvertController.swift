//
//  ConvertController.swift
//  Converter
//
//  Created by Anthony Jean on 27/01/2019.
//  Copyright © 2019 Anthony Jean. All rights reserved.
//

import UIKit

class ConvertController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var toDoLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var dataTextField: UITextField!
    
    @IBOutlet weak var entryView: UIView!
    @IBOutlet weak var resultView: UIView!
    
    var type: String?
    var views: [UIView] = []
    var isReverse = false
    let euros = "euros"
    let dollars = "dollars"
    let km = "kilomètres"
    let mi = "miles"
    let celsius = "celsius"
    let fahrenheit = "fahrenheit"
    let format = "%.2f"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let choice = type {
            titleLabel.text = "Convertisseur de " + choice
            views = [entryView, resultView]
            addViewStyle()
            chosenType(choice)
        } else {
            dismiss(animated: true, completion: nil)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)

    }
    
    // Functions
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    func setup(_ primary: String, _ secondary: String) {
        if !isReverse {
            titleLabel.text = "Convertir " + primary + " en " + secondary
            toDoLabel.text = "Entrez votre valeur en " + primary
        } else {
            titleLabel.text = "Convertir " + secondary + " en " + primary
            toDoLabel.text = "Entrez votre valeur en " + secondary
        }
    }
    
    func chosenType(_ choice: String) {
        switch choice {
        case DEVISE: setup(euros, dollars)
        case DISTANCE: setup(km, mi)
        case TEMPERATURE: setup(celsius, fahrenheit)
        default: break
        }
    }
    
    func addViewStyle() {
        for view in views {
            view.layer.cornerRadius = 3
        }
    }
    
    // Calculation logic
    func calculate() {
        if  let myType = type,
            let text = dataTextField.text,
            let value = Double(text) {
            switch myType {
            case DEVISE:
                resultLabel.text = isReverse ? euros(value) : dollars(value)
            case DISTANCE:
                resultLabel.text = isReverse ? km(value) : miles(value)
            case TEMPERATURE:
                resultLabel.text = isReverse ? celsius(value) : fahrenheit(value)
            default: break
            }
        }
    }
    
    func dollars(_ euros: Double) -> String {
        return String(format: format, (euros / 0.81)) + " $"
    }
    func euros(_ dollars: Double) -> String {
        return String(format: format, (dollars * 0.81)) + " €"
    }
    func miles(_ km: Double) -> String {
        return String(format: format, (km * 0.621)) + " mi"
    }
    func km(_ miles: Double) -> String {
        return String(format: format, (miles / 0.621)) + " km"
    }
    func celsius(_ fahrenheit: Double) -> String {
        return String(format: format, ((fahrenheit - 32) / 1.8)) + " °C"
    }
    func fahrenheit(_ celsius: Double) -> String {
        return String(format: format, ((celsius * 1.8) + 32)) + " °F"
    }
    
    // Actions
    
    @IBAction func changeButton(_ sender: Any) {
        guard type != nil else { return }
        isReverse = !isReverse
        chosenType(type!)
        calculate()
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        calculate()
    }
    
}
