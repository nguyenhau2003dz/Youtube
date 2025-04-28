import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
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
    
    private let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Đăng nhập", for: .normal)
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return btn
    }()
    
    private let registerButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Đăng ký", for: .normal)
        btn.addTarget(self, action: #selector(goToRegister), for: .touchUpInside)
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
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
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
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 15),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func handleLogin() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else {
            print("Missing fields")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Login error:", error.localizedDescription)
            } else {
                let homeVC = HomeViewController()
                self.navigationController?.pushViewController(homeVC, animated: true)
                print("Login thành công!")
            }
        }
    }
    
    @objc private func goToRegister() {
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
}

