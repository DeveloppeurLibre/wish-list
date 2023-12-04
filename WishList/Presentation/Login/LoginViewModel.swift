//
//  LoginViewModel.swift
//  WishList
//
//  Created by Quentin Cornu on 20/10/2023.
//

import Foundation
import FirebaseAuth

@MainActor
class LoginViewModel: ObservableObject {
    
    // MARK: Published properties
    
    @Published var email: String
    @Published var name: String
    @Published var mode: Mode
    @Published var password: String
    @Published var errorMessage: String
    @Published var isShowingHomeView: Bool
    @Published var isShowingSignupView: Bool
    
    // MARK: Computed properties
    
    var changeModeTextIndication: String {
        switch mode {
        case .login:
            return "Pas encore de compte ?"
        case .signup:
            return "Déjà inscrit ?"
        }
    }
    
    var confirmButtonText: String {
        switch mode {
        case .login:
            return "Se connecter"
        case .signup:
            return "Créer un compte"
        }
    }
    
    var changeModeButtonText: String {
        switch mode {
        case .login:
            return "Créer un compte"
        case .signup:
            return "Se connecter"
        }
    }
    
    // MARK: Initializers
    
    init() {
        self.email = ""
        self.name = ""
        self.mode = .signup
        self.password = ""
        self.errorMessage = ""
        self.isShowingHomeView = false
        self.isShowingSignupView = false
    }
    
    func confirmForm() {
        self.errorMessage = ""
        Task {
            switch mode {
            case .login:
                login()
            case .signup:
                createAccount()
            }
        }
    }
    
    func changeMode() {
        self.errorMessage = ""
        switch mode {
        case .login:
            self.mode = .signup
        case .signup:
            self.mode = .login
        }
    }
    
    func signupButtonPressed() {
        self.isShowingSignupView = true
    }
    
    // MARK: Private functions
    
    private func createAccount() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error as? NSError {
                switch AuthErrorCode(_nsError: error).code {
                case .invalidEmail:
                    self.errorMessage = "Cet email est invalide."
                case .emailAlreadyInUse:
                    self.errorMessage = "Cet email est est déjà utilisé pour un autre compte."
                case .weakPassword:
                    self.errorMessage = "Le mot de passe doit contenir au moins 6 caractère."
                default:
                    self.errorMessage = "Une erreur inconnue est survenue."
                }
            } else {
                Task {
                    guard let userId = authResult?.user.uid else {
                        self.errorMessage = "Une erreur inconnue est survenue."
                        return
                    }
                    try await FirebaseDatabaseDataSource.shared.createNewUser(id: userId, email: self.email, name: self.name)
                    self.isShowingHomeView = true
                }
            }
        }
    }
    
    private func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error as? NSError {
                let errorCode = AuthErrorCode(_nsError: error).code
                switch errorCode {
                case .invalidEmail:
                    self.errorMessage = "Cet email est invalide."
                case .wrongPassword:
                    self.errorMessage = "Le mot de passe est incorrect."
                default:
                    self.errorMessage = "Une erreur inconnue est survenue."
                }
            } else {
                self.isShowingHomeView = true
            }
        }
    }
    
    enum Mode {
        case login
        case signup
    }
}
