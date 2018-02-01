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

    @IBOutlet weak var loginOptionSegmentControl: UISegmentedControl! // This holds the user login option for the app.
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginSignUpButton: UIButton!
    
    @IBOutlet weak var subView: UIView!
    
    var chosenLoginMethod = 0 // This is to decide whether to login or create a user based on the email and password given.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
    }
    
    // MARK: View Design + Functionality:
    func setupView() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))) // Enables the user to dismiss the keyboard when they tap anywhere in the view.
        self.subView.layer.cornerRadius = 20 // Round the corners of the subview.
        
        // LoginButton setup.
        self.loginSignUpButton.backgroundColor = UIColor.white
        self.loginSignUpButton.layer.cornerRadius = 10
    }
    
    @IBAction func loginOptionSegmentControlChanged(_ sender: Any) {
        if (loginOptionSegmentControl.selectedSegmentIndex == 0) {
            chosenLoginMethod = 0
            print("Chosen Login")
            loginSignUpButton.setTitle("Login", for: .normal) // Change the title label of the sign up button to make sure that the user knows which sign in option they've chosen.
        }else if (loginOptionSegmentControl.selectedSegmentIndex == 1) {
            chosenLoginMethod = 1
            print("Chosen Sign Up")
            loginSignUpButton.setTitle("Sign Up", for: .normal) // Change the title label of the sign up button to make sure that the user knows which sign in option they've chosen.
        }
    }
    
    @IBAction func loginSignUpButtonTapped(_ sender: Any) {
        print("chosenLoginMethod value: \(chosenLoginMethod)")
        if (chosenLoginMethod == 0) {
            login()
        }else if (chosenLoginMethod == 1) {
            signUp()
        }
    }
    
    func login() { // Logs the user into the app with the provided email and password.
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
    
    func signUp() { // Creates a new user with the provided email and password
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
