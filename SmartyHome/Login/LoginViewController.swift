//
//  LoginViewController.swift
//  SmartyHome
//
//  Created by Ahmed MAHOUCHI on 10/25/20.
//

import Foundation
import UIKit
import SVGKit
import Toaster

class LoginViewController: UIViewController ,UITextViewDelegate, UITextFieldDelegate{

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    @IBOutlet weak var nameTextField: UITextField!
    
    fileprivate let loginPresenter = LoginPresenter(loginService: LoginService())

    override func viewDidLoad() {
        super.viewDidLoad()
        loginPresenter.attachView(self)
        let namSvgImgVar: SVGKImage = SVGKImage(named: "home")
        image.image = namSvgImgVar.uiImage
        nameTextField.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    @IBAction func continueBtnDidTap(_ sender: Any)  {
        if nameTextField.text!.isEmptyOrNull {
            Toast(text:"please add your name").show()
        }
        else {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let roomVC = storyBoard.instantiateViewController(withIdentifier: "RoomsViewController") as! RoomsViewController
            roomVC.username = nameTextField.text ?? "user"
            self.navigationController?.pushViewController(roomVC, animated: true)
        }
    }
}
//MARK:- TextField Delegates
extension LoginViewController {
    /// This is called When the return button is tapped. Focuses next textfield if exists, else dismisses keyboard.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let tag = textField.tag + 1
        let nextTextField = self.view.viewWithTag(tag) as? UITextField
        
        if nextTextField != nil {
            nextTextField?.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }
        return false
    }
}
extension LoginViewController: LoginView {

    func startLoading() {
        activityIndicator?.startAnimating()
    }

    func finishLoading() {
        activityIndicator?.stopAnimating()
    }
}
