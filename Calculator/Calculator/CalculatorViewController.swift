//
//  ViewController.swift
//  Calculator
//
//  Created by Furkan Beyhan on 3.04.2019.
//  Copyright © 2019 Furkan Beyhan. All rights reserved.
//

import UIKit
import CoreData
import FirebaseAuth

class CalculatorViewController: UIViewController{

    
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var mathTextField: UITextField!
    
    var password : String?
    
    var isTypingNumber = false
    var firstNumber : Double?
    var secondNumber : Double?
    var operation = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mathTextField.layer.cornerRadius = 10
        mathTextField.layer.borderWidth = 1
        mathTextField.layer.borderColor = UIColor(displayP3Red: 0.777, green: 1, blue: 0.001, alpha: 1).cgColor
        
        answerTextField.layer.cornerRadius = 10
        answerTextField.layer.borderWidth = 1
        answerTextField.layer.borderColor = UIColor(displayP3Red: 0.777, green: 1, blue: 0.001, alpha: 1).cgColor
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        mathTextField.text = ""
        answerTextField.text = ""
    }
    @IBAction func acButton(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Password")
        
        request.returnsObjectsAsFaults = false
        
        do{
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "password") as! String)
                password = data.value(forKey: "password") as? String
            }
            if password == mathTextField.text{
                if Auth.auth().currentUser != nil {
                    print("Already registered")
                    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "chatView") as! ChatViewController
                    navigationController?.pushViewController(vc, animated: true)
                }else if Auth.auth().currentUser == nil {
                    print("Not Registered")
                    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "registerView") as! RegisterViewController
                    navigationController?.pushViewController(vc, animated: true)
                }
            }else{
            }
        }catch {
            print("SOOO Failed")
        }
        mathTextField.text = ""
        answerTextField.text = ""
    }
    
    
    @IBAction func calculationTapped(_ sender: AnyObject) {
        if mathTextField.text != ""{
            print("Current Title : \(sender.currentTitle!!)")
            isTypingNumber = false
            firstNumber = Double(mathTextField.text!)!
            operation = sender.currentTitle!!
        }
    }
    
    @IBAction func numberTapped(_ sender: AnyObject) {
        let number = sender.currentTitle
        
        if isTypingNumber {
            mathTextField.text = "\(mathTextField.text!)" + "\(number!!)"
        } else {
            mathTextField.text = "\(number!!)"
            isTypingNumber = true
        }
        
    }
    
    
    @IBAction func equalButton(_ sender: AnyObject) {
        
        isTypingNumber = false
        var result : Double = 0
        secondNumber = Double(mathTextField.text!)!
        
        if operation == "+" {
            result = firstNumber! + secondNumber!
        } else if operation == "-" {
            result = firstNumber! - secondNumber!
        } else if operation == "X" {
            result = firstNumber! * secondNumber!
        } else if operation == "/" {
            result = firstNumber! / secondNumber!
        }
        answerTextField.text = "\(result)"
        mathTextField.text = ""
    }
    
    
    
    
}
