//
//  RegisterViewController.swift
//  Calculator
//
//  Created by Furkan Beyhan on 3.04.2019.
//  Copyright © 2019 Furkan Beyhan. All rights reserved.
//

import UIKit
import FirebaseAuth
import CoreData

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginEmailTextField: UITextField!
    @IBOutlet weak var loginPassTextField: UITextField!
    
    var password : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Password")

        if Auth.auth().currentUser != nil{
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
                }else if password == nil{
                    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "firstView") as! FirstViewController
                    navigationController?.pushViewController(vc, animated: true)
                    print("ŞİFRE :")
                }
            }catch {
                print("SOOO Failed")
            }
        }

        loginEmailTextField.attributedPlaceholder = NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 0.77, green: 1, blue: 0.01, alpha: 0.4)])
        loginPassTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 0.77, green: 1, blue: 0.01, alpha: 0.4)])
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 0.77, green: 1, blue: 0.01, alpha: 0.4)])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 0.77, green: 1, blue: 0.01, alpha: 0.4)])
    }
    
    @IBAction func loginButton(_ sender: Any) {
        Auth.auth().signIn(withEmail: loginEmailTextField.text!, password: loginPassTextField.text!) { (user, error) in
            
            if error == nil {
                self.loginPassTextField.text = ""
                self.loginEmailTextField.text = ""
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "firstView") as! FirstViewController
                let ncncnc = UINavigationController(rootViewController: vc)
                self.present(ncncnc, animated: true, completion: nil)
            }else{
                let alertController = UIAlertController(title: "Hata", message: "Mailinizi veya şifrenizi yanlış girdiniz. Lütfen bilgilerinizi kontrol ederek tekrar deneyiniz", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Tamam", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil) 
            }
        }
    }
    
    
    @IBAction func registerButtonClicked(_ sender: Any) {
        if passwordTextField.text != "" && emailTextField.text != ""{
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                if error == nil {
                    let alert = UIAlertController(title: "Congratulations", message: "You have succesfully registered", preferredStyle: .alert)
                    let okay : UIAlertAction = UIAlertAction(title: "Okay", style: .default) { (action) in
                        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "firstView") as! FirstViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    alert.addAction(okay)
                    self.present(alert, animated: true, completion: nil)
                }else{
                    let alertController = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }else{
            let alertController = UIAlertController(title: "Error", message: "Please fill the blanks", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
