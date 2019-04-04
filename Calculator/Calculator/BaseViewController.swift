//
//  BaseViewController.swift
//  Calculator
//
//  Created by Furkan Beyhan on 4.04.2019.
//  Copyright © 2019 Furkan Beyhan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func popToRoot(){
        let _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
}
