//
//  ViewController.swift
//  Organise
//
//  Created by Thomas Houghton on 01/02/2018.
//  Copyright © 2018 Thomas Houghton. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginSignUpViewController: UIViewController {
    
    // Outlets:
    @IBOutlet weak var loginOptionSegmentControl: UISegmentedControl! // Holds the user login option for the app.
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginSignUpButton: UIButton!
    @IBOutlet weak var subView: UIView!
    
    // Variables:
    var chosenLoginMethod = 0 // Decides whether to login or create a user based on the email and password given.
    
    // MARK: View Setup:
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
    }
    
    func setupView() {
        // Dismiss Keyboard:
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        self.subView.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        // Subview:
        self.subView.layer.cornerRadius = 20
        
        // Email Text Field:
        emailTextField.backgroundColor = UIColor.init(red: 16/255, green: 156/255, blue: 146/255, alpha: 1)
        emailTextField.layer.cornerRadius = 10
        
        // Password Text Field:
        passwordTextField.backgroundColor = UIColor.init(red: 16/255, green: 156/255, blue: 146/255, alpha: 1)
        passwordTextField.layer.cornerRadius = 10
        
        // LoginButton setup.
        self.loginSignUpButton.backgroundColor = UIColor.white
        self.loginSignUpButton.layer.cornerRadius = 10
    }
    
    // MARK: Actions:
    @IBAction func loginOptionSegmentControlChanged(_ sender: Any) {
        if (loginOptionSegmentControl.selectedSegmentIndex == 0) {
            chosenLoginMethod = 0
            loginSignUpButton.setTitle("Login", for: .normal) // Change the title label of the sign up button.
        }else if (loginOptionSegmentControl.selectedSegmentIndex == 1) {
            chosenLoginMethod = 1
            loginSignUpButton.setTitle("Sign Up", for: .normal) // Change the title label of the sign up button.
        }
    }
    
    @IBAction func loginSignUpButtonTapped(_ sender: Any) {
        print("chosenLoginMethod value: \(chosenLoginMethod)")
        if (chosenLoginMethod == 0) {
            login() // Login to the app.
        }else if (chosenLoginMethod == 1) {
            signUp() // Create a new user.
        }
    }
    
    // Firebase Authentication:
    func login() { // Login a user.
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if (error != nil) {
                print("We couldn't log in the user \(String(describing: error))")
            }else{
                print("We managed to log the user in")
                // Do a segue to the timetable storyboard.
                self.performSegue(withIdentifier: "AppEntrySegue", sender: nil)
            }
        }
    }
    
    func signUp() { // Create a new user.
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if (error != nil) {
                print("We couldn't create a new user \(String(describing: error))")
            }else{
                Database.database().reference().child("users").child(user!.uid).child("email").setValue(self.emailTextField.text!)
                print("Created a new user")
                self.performSegue(withIdentifier: "AppEntrySegue", sender: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
