//
//  ViewController.swift
//  Converter
//
//  Created by Anthony Jean on 26/01/2019.
//  Copyright © 2019 Anthony Jean. All rights reserved.
//

import UIKit

let DEVISE = "Devise"
let TEMPERATURE = "Température"
let DISTANCE = "Distance"

class ViewController: UIViewController {

    @IBOutlet weak var currencyView: UIView!
    @IBOutlet weak var distanceView: UIView!
    @IBOutlet weak var temperatureView: UIView!
    
    let segueID = "Convert"
    var views: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        views = [currencyView, distanceView, temperatureView]
        addViewStyle()
        
    }
    
    func addViewStyle() {
        for view in views {
            view.layer.cornerRadius = 3
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueID {
            if let convertController = segue.destination as? ConvertController {
                convertController.type = sender as? String
            }
        }
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        switch sender.tag {
        case 0: performSegue(withIdentifier: segueID, sender: DEVISE)
        case 1: performSegue(withIdentifier: segueID, sender: DISTANCE)
        case 2: performSegue(withIdentifier: segueID, sender: TEMPERATURE)
        default: break
        }
    }
    
}

