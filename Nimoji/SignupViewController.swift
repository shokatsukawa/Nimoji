//
//  SignupViewController.swift
//  Nimoji
//
//  Created by Sho Katsukawa on 2017/04/28.
//
//

import UIKit
import Firebase
import FirebaseAuth
import SVProgressHUD

class SignupViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        usernameTextField.layer.borderWidth = 2
        emailTextField.layer.borderWidth = 2
        passTextField.layer.borderWidth = 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func pushSignupButton(_ sender: Any) {
        if let username = usernameTextField.text,
           let email = emailTextField.text,
           let password = passTextField.text {
            if username.characters.isEmpty {
                SVProgressHUD.showError(withStatus: "Oops!")
                usernameTextField.layer.borderColor = UIColor.red.cgColor
                return
            }
            if email.characters.isEmpty {
                SVProgressHUD.showError(withStatus: "Oops!")
                emailTextField.layer.borderColor = UIColor.red.cgColor
                return
            }
            if password.characters.isEmpty {
                SVProgressHUD.showError(withStatus: "Oops!")
                passTextField.layer.borderColor = UIColor.red.cgColor
                return
            }
            usernameTextField.layer.borderColor = UIColor.black.cgColor
            emailTextField.layer.borderColor = UIColor.black.cgColor
            passTextField.layer.borderColor = UIColor.black.cgColor
            
            // ユーザー作成
            FIRAuth.auth()?.createUser(withEmail: email, password: password) { user, error in
                if let error = error {
                    print(error)
                    SVProgressHUD.showError(withStatus: "Error!")
                    return
                }
                // ユーザーネームを設定
                let user = FIRAuth.auth()?.currentUser
                if let user = user {
                    let changeRequest = user.profileChangeRequest()
                    changeRequest.displayName = username
                    changeRequest.commitChanges { error in
                        if let error = error {
                            print(error)
                            SVProgressHUD.showError(withStatus: "Error!")
                        }
                        SVProgressHUD.showSuccess(withStatus: "Success!")
                    }
                } else {
                    print("DEBUG_PRINT: displayNameの設定に失敗しました。")
                }
            }
        }
    }
}
