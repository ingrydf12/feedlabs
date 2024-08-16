import Foundation
import FirebaseAuth

@Observable
class LoginViewModel {
    
    let coordinator: AuthCoordinator
    
    var email: String = ""
    var password: String = ""
    var emailError: String?
    var passwordError: String?
    
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    
    func validateInputs() -> Bool {
        var isValid = true
        
        if email.isEmpty {
            emailError = "O campo e-mail não pode estar vazio."
            isValid = false
        } else if !isValidEmail(email) {
            emailError = "Insira um e-mail válido."
            isValid = false
        } else {
            emailError = nil
        }
        
        if password.isEmpty {
            passwordError = "O campo senha não pode estar vazio."
            isValid = false
        } else {
            passwordError = nil
        }
        
        return isValid
    }
    
    func handleLogin() {
        if validateInputs() {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    print(error.localizedDescription)
                    self.passwordError = "E-mail ou senha incorretos."
                    return
                }
                guard let user = result?.user else { return }
                print("User logged in successfully with uid: \(user.uid)")
                // Navegar para a próxima tela aqui, se necessário
            }
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

