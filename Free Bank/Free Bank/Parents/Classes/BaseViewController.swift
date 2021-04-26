//
//  BaseViewController.swift
//  Free Bank
//
//  Created by Sasha Zontova on 4/26/21.
//

import AMPopTip
import Reachability
import UIKit

class BaseViewController: UIViewController {
    private let popTip = PopTip()
    var reachability = try? Reachability()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Login
    func checkLogin(login: String) -> Bool {
        let allowLetters: ClosedRange<Character> = "A"..."z"
        let allowLNumbers: ClosedRange<Character> = "0"..."9"
        let allowSymbols: Set<Character> = [".", "_"]
        if login.count < 8 || login.count > 30 {
            showAlertMessage("Неверный формат логина. Проверьте данные.", "Ошибка")
            return false
        }
        for symb in login {
            if  (!allowLetters.contains(symb)) || (!allowSymbols.contains(symb)) || (!allowLNumbers.contains(symb)) {
                showAlertMessage("Логин содержит недопустимые символы. Проверьте данные.", "Ошибка")
                return false
            }
        }
        return true
    }
    // MARK: Password
    func checkPassword(password: String) -> Bool {
        if password.count < 8 || password.count > 50 {
            showAlertMessage("Пароль должен быть не короче 8 и не длиннее 50 символов. Проверьте данные.", "Ошибка")
            return false
        }
        let allowNumbers: ClosedRange<Character> = "0"..."9"
        var hasUpChar = false
        var hasLowChar = false
        var hasNumber = false
        for symb in password {
            if !hasLowChar {
                if String(symb).lowercased() == String(symb) {
                    hasLowChar = true
                    if hasUpChar && hasLowChar && hasNumber { break }
                }
            }
            if !hasUpChar {
                if String(symb).uppercased() == String(symb) {
                    hasUpChar = true
                    if hasUpChar && hasLowChar && hasNumber { break }
                }
            }
            if !hasNumber {
                if allowNumbers.contains(symb) {
                    hasNumber = true
                    if hasUpChar && hasLowChar && hasNumber { break }
                }
            }
        }
        if (!hasNumber) || (!hasUpChar) || (!hasLowChar) {
            showAlertMessage("Пароль должен содержать минимум одну цифру, одну строчную и одну прописную букву.", "Ошибка")
            return false
        }
       return true
    }
    // MARK: PRN
    func checkUNP(unp: String) -> Bool {
        if unp.count != 9 {
            showAlertMessage("Неверный формат УНП. Проверьте данные.", "Ошибка")
            return false
        }
        if Int(unp) != nil {
           //
        } else {
            showAlertMessage("УНП содержит посторонние символы. Проверьте данные.", "Ошибка")
            return false
        }
        return true
    }
    // MARK: IndividName
    func checkPersonName (name: String) -> Bool {
        let allowLetters: ClosedRange<Character> = "А"..."я"
        let allowSymbols: Set<Character> = ["ё"]
        let words = name.components(separatedBy: [" "])
        if words.count != 3 {
            showAlertMessage("ФИО должно состоять из трёх слов", "Ошибка")
            return false
        }
        for word in words {
            for symb in word {
                if  !allowLetters.contains(symb) && (!allowSymbols.contains(symb)) {
                    showAlertMessage("ФИО содержит посторонние символы", "Ошибка")
                    return false
                }
            }
        }
        return true
    }
    // MARK: OrganizationName
    func checkOrgName (name: String) -> Bool {
        let allowLetters: ClosedRange<Character> = "А"..."я"
        let allowNumbers: ClosedRange<Character> = "0"..."9"
        let allowSymbols: Set<Character> = [" ", "-", "ё"]
        if name.count > 50 {
            showAlertMessage("Название компании превышает допустимую длину", "Ошибка")
            return false
        }
        for symb in name {
            if (!allowLetters.contains(symb)) && (!allowNumbers.contains(symb)) && (!allowSymbols.contains(symb)) {
                showAlertMessage("Название компании превышает допустимую длину", "Ошибка")
                return false
            }
        }
        return true
    }
    // MARK: Email
    func checkEmail (email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        if !emailPred.evaluate(with: email) {
            showAlertMessage("Email ведён некорректно", "Ошибка")
            return false
        }
        return true
    }
    // MARK: CreditProperties
    func checkCreditAmount(_ amount: Int) -> Bool {
        if amount < 100 || amount > 10000 {
            showAlertMessage("Неверно введена сумма кредита.\nМинимальная сумма - 100 BYR\nМаксимальная - 10000 BYR", "Ошибка")
            return false
        }
        return true
    }
    func checkCreditTerm(_ term: Int) -> Bool {
        if term < 6 || term > 84 {
            showAlertMessage("Неверно введен срок кредита.\nМинимальный срок - 6 месяцев\nМаксимальный - 84 месяца", "Ошибка")
            return false
        }
        return true
    }
    func checkCreditSalary(_ amount: Int) -> Bool {
        if amount < 782 || amount > 2500 {
            showAlertMessage("Неверно введен минимальный доход.\nМинимальный доход - 782 BYR\nМаксимальный - 2500 BYR", "Ошибка")
            return false
        }
        return true
    }
    // MARK: - CheckDatasInPages
    // MARK: SignIn
    func checkSignInDatas(_ status: Int, _ login: String, _ password: String) -> Bool {
        if login.isEmpty || password.isEmpty {
            showAlertMessage("Введите логин и пароль.", "Ошибка")
            return false
        }
        switch status {
        case 0:
            if !checkLogin(login: login) { return false }
        case 1:
            if !checkUNP(unp: login) { return false }
        default: break
        }
        return true
    }
    // MARK: SignUP
    func checkSignUpDatas(_ status: Int, _ name: String, _ email: String, _ login: String, _ password: String, _ repeatPassword: String) -> Bool {
        if name.isEmpty || login.isEmpty || password.isEmpty || repeatPassword.isEmpty || email.isEmpty {
            showAlertMessage("Не все поля заполнены.", "Ошибка")
            return false
        }
        switch status {
        case 0:
            if !checkPersonName(name: name) { return false }
            if !checkLogin(login: login) { return false }
            if CoreDataConstants.db.findIndivididual(by: login) != nil {
                showAlertMessage("Данный логин занят другим пользователем", "Ошибка")
                return false
            }
        case 1:
            if !checkOrgName(name: name) { return false }
            if !checkUNP(unp: login) { return false }
            if CoreDataConstants.db.findOrganization(by: login) != nil {
                showAlertMessage("Вы ввели уже существующий УНП", "Ошибка")
                return false
            }
        default: break
        }
        if !checkEmail(email: email) { return false }
        if !checkPassword(password: password) { return false }
        if password != repeatPassword {
            showAlertMessage("Пароли не совпадают", "Ошибка")
            return false
        }
        return true
    }
    // MARK: Credit
    func checkCreditDatas(_ amount: Int, _ term: Int, _ salary: Int) -> Bool {
        if amount == 0 || term == 0 || salary == 0 {
            showAlertMessage("Не все поля заполнены.", "Ошибка")
            return false
        }
        if !checkCreditAmount(amount) {return false}
        if !checkCreditTerm(term) {return false}
        if !checkCreditSalary(salary) {return false}
        return true
    }
    // MARK: Transaction
    func checkAccountBalance(_ amount: Int64, _ balance: Int64) -> Bool {
        if balance - amount < 0 {
            return false
        }
        return true
    }
    
    func showInfo(_ button: UIButton, _ number: Int, _ text: String) {
        popTip.bubbleColor = .init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.7)
        let infoString = text
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        let fontStyle = UIFont.systemFont(ofSize: 14)
        let attributes: [NSAttributedString.Key: Any] = [.paragraphStyle: paragraphStyle, .font: fontStyle, .foregroundColor: UIColor.black]
        let attributedString = NSAttributedString(string: infoString , attributes:attributes)
        let oldView = view.subviews[number]
        oldView.frame = CGRect(x: oldView.frame.minX, y: oldView.frame.minY, width: oldView.frame.width - 30, height: oldView.frame.height)
        popTip.show(attributedText: attributedString, direction: .up, maxWidth: 200, in: oldView, from: button.frame)
    }
    
    func checkConnection() {
        reachability = try? Reachability()
        reachability?.whenReachable = { reachability in
            if reachability.connection == .wifi {} else {}
        }
        reachability?.whenUnreachable = { _ in }
        do {
            try reachability?.startNotifier()
        } catch {}
        reachability?.stopNotifier()
    }
}
