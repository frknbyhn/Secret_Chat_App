//
//  FirstViewController.swift
//  Calculator
//
//  Created by Furkan Beyhan on 3.04.2019.
//  Copyright © 2019 Furkan Beyhan. All rights reserved.
//

import UIKit
import CoreData
import FirebaseAuth

class FirstViewController: BaseViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var passText: UITextField!
    
    var password : String?
    var data : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Password")
        
        do{
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "password") as! String)
                password = data.value(forKey: "password") as? String
                print("ŞİFRE : \(password!)")
            }
            if password != nil{
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "mainView") as! CalculatorViewController
                navigationController?.pushViewController(vc, animated: true)
            }else{
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "firstView") as! FirstViewController
                navigationController?.pushViewController(vc, animated: true)
            }
        }catch{
                print("SOOO Failed")
        }

        passText.attributedPlaceholder = NSAttributedString(string: "Numbers Only", attributes: [NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 0.77, green: 1, blue: 0.01, alpha: 0.35)])
        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = passText.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 4
    }
    
    
    @IBAction func setButton(_ sender: Any) {

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Password", in: context)
        let newPass = NSManagedObject(entity: entity!, insertInto: context)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Password")
        
        fetchRequest.returnsObjectsAsFaults = false

        let pin = "\(passText.text!)"
        
        newPass.setValue(pin, forKey: "password")
        do {
            try context.save()
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "mainView") as! CalculatorViewController
            let ncncnc = UINavigationController(rootViewController: vc)
            ncncnc.isNavigationBarHidden = true
            self.present(ncncnc, animated: true, completion: nil)
        } catch {
            print("Failed saving")
        }
    }
}
