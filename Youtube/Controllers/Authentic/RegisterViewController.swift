//
//  RegisterViewController.swift
//  Youtube
//
//  Created by Hậu Nguyễn on 27/4/25.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.borderStyle = .roundedRect
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let registerButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Đăng ký", for: .normal)
        btn.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalToConstant: 300),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: emailTextField.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            
            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - Actions
    @objc private func handleRegister() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else {
            print("Missing fields")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Registration error:", error.localizedDescription)
            } else {
                print("Đăng ký thành công!")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
