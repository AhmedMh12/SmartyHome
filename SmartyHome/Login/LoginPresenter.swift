//
//  LoginPresenter.swift
//  SmartyHome
//
//  Created by Ahmed MAHOUCHI on 10/25/20.
//

import Foundation
protocol LoginView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
  
}

class LoginPresenter {
    fileprivate let loginService:LoginService
    weak fileprivate var loginView : LoginView?
    
    init(loginService:LoginService){
        self.loginService = loginService
    }
    
    func attachView(_ view:LoginView){
        loginView = view
    }
    
    func detachView() {
        loginView = nil
    }
}
