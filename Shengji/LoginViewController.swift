//
//  LoginViewController.swift
//  Shengji
//
//  Created by Kevin Peng on 2020-08-09.
//

import UIKit

extension UIColor {
    static var defaultGray: UIColor {
        UIColor(red: 0x97/0xFF, green: 0x97/0xFF, blue: 0x97/0xFF, alpha: 1)
    }
}

class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Shengji"
        lbl.font = .systemFont(ofSize: 80)
        return lbl
    }()
    
    private lazy var usernameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Username"
        return lbl
    }()
    
    private lazy var passwordLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Secret Passcode"
        return lbl
    }()
    
    private lazy var usernameTextField: BorderedTextField = {
        let tf = BorderedTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = " Username"
        tf.widthAnchor.constraint(equalToConstant: 274).isActive = true
        tf.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return tf
    }()
    
    private lazy var passwordTextField: BorderedTextField = {
        let tf = BorderedTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = " Secret Passcode"
        tf.widthAnchor.constraint(equalToConstant: 274).isActive = true
        tf.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return tf
    }()
    
    private lazy var loginButton: BorderedButton = {
        let button = BorderedButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    func setupUI() {
        let textFieldStackView = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField])
        textFieldStackView.translatesAutoresizingMaskIntoConstraints = false
        textFieldStackView.axis = .vertical
        
        view.addSubview(textFieldStackView)
        textFieldStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textFieldStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.backgroundColor = .white
        
        view.addSubview(usernameLabel)
        view.addSubview(passwordLabel)
        usernameLabel.trailingAnchor.constraint(equalTo: usernameTextField.leadingAnchor, constant: -16).isActive = true
        usernameLabel.firstBaselineAnchor.constraint(equalTo: usernameTextField.firstBaselineAnchor).isActive = true
        passwordLabel.trailingAnchor.constraint(equalTo: usernameTextField.leadingAnchor, constant: -16).isActive = true
        passwordLabel.firstBaselineAnchor.constraint(equalTo: passwordTextField.firstBaselineAnchor).isActive = true
        
        view.addSubview(titleLabel)
        titleLabel.bottomAnchor.constraint(equalTo: usernameTextField.topAnchor, constant: -16).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: usernameTextField.centerXAnchor).isActive = true
        
        view.addSubview(loginButton)
        loginButton.heightAnchor.constraint(equalTo: textFieldStackView.heightAnchor).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: usernameTextField.trailingAnchor, constant: 8).isActive = true
        loginButton.widthAnchor.constraint(equalTo: loginButton.heightAnchor, multiplier: 1).isActive = true
        loginButton.topAnchor.constraint(equalTo: textFieldStackView.topAnchor).isActive = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}
