//
//  MainViewModel.swift
//  NumerologyApp
//
//  Created by Tetiana on 29.01.2021.
//

import UIKit

typealias MainProps = MainViewController.Props

protocol MainViewModelType {
    var didLoadData: ((MainProps) -> Void)? { get set }
    
    func calculate()
    func updateProps() 
}

final class MainViewModel: MainViewModelType {
    
    private let coordinator: MainCoordinatorType
    private var serviceHolder: ServiceHolder
        
    private var screenState: MainProps.MainScreenState = .initial
    private var enteredString: String?
    private var result: Int = 0
    private var descriptionText = ""
    
    var didLoadData: ((MainProps) -> Void)?
    
    init(_ coordinator: MainCoordinatorType, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
        self.serviceHolder = serviceHolder
        updateProps()
    }
    
    func updateProps() {
        let props: MainProps = .init(
            state: screenState,
            insertLabelText: "Insert the text: ",
            enteredString: enteredString,
            resultLabelText: "Result",
            result: "\(result)",
            btnTitle: "Calculate",
            descriptionText: getDescription(of: result),
            infoAction: Command {
                self.coordinator.showAlert(title: "Info", message: self.getInfo())
            },
            calculateAction: Command {
                self.calculate()
                self.screenState = .calculated
                self.updateProps()
            },
            changeTextAction: CommandWith { text in
                self.enteredString = text
                self.updateProps()
            }
        )
        DispatchQueue.main.async {
            self.didLoadData?(props)
        }
    }

     func calculate() {
        self.result = getResult(enteredString)
        updateProps()
    }
    
    private func getDescription(of number: Int) -> String {
        switch number {
        case 0:
            return "Олицетворяет абсолютное небытие, непроявленность материи."
        case 1:
            return "Власть, могущество, мужество, отвага, жизненная стойкость."
        case 2:
            return "Изящество, женственность, деликатность, гибкость, партнерство."
        case 3:
            return "Фантазия, творчество; образ жизни, характерный для «звезды»."
        case 4:
            return "Устойчивость, последовательность, труд, терпение, организованность."
        case 5:
            return "Мобильность, изменчивость, перемена мест, любознательность, сенсация."
        case 6:
            return "Гармоничность, спокойствие, романтика, семейный очаг."
        case 7:
            return "Путь исследователя, философский склад ума, самоанализ."
        case 8:
            return "Материальность, мудрость, уверенность, компромисс."
        case 9:
            return "Коммуникабельность, масштаб, универсальность, многообразие."
        default:
            return "Error! Incorrect algorythm!"
        }
    }
    
    private func cleanStr(_ string: String) -> String {
        do {
            // Строка чистится от всех символов, кроме 1-8 (0 и 9 на результат суммирования не влияют, потому их можно выбросить сразу для сокращения количества операций), путём фильтрации с помощью RegEx [1-8].

            let regex = try NSRegularExpression(pattern: "[1-8]")
            let results = regex.matches(in: string,
                                        range: NSRange(string.startIndex..., in: string))
            let result = results.compactMap {
                Range($0.range, in: string).map { String(string[$0]) }
            }
            return result.joined()
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return ""
        }
    }
    
    private func getResult(_ string: String?) -> Int {
        guard let string = string else { return 0 }
        if string.count == 1 {
            return Int(string) ?? 0
        }
        var str = cleanStr(string)
        while (str.count > 1) {
            str = summAllChars(str)
        }
        return Int(str) ?? 0
    }
    
    private func summAllChars(_ str: String) -> String {
        var sum = 0
        for char in str {
            sum += Int("\(char)") ?? 0
        }
        return "\(sum)"
    }
    
    private func getInfo() -> String {
        return """
            Как производится расчет чисел в нумерологии?
            Чтобы выяснить значение чисел любой величины, применяется метод сложения (нумерологической редукции). Эта методика приведения сложного к простому помогает сокращать все цифровые значения до простых чисел от 1 до 9. В ее основе лежит принцип, говорящий о том, что элементарные цифры - это исходные элементы, которыми можно выразить все числовое многообразие.

            Например, произведя последовательно два сложения, число 88357 превращается в число 31, а затем в цифру 4.

            ШАГ 1. 88357 → 88357 → 8 + 8 + 3 + 5 + 7 = 31
            ШАГ 2. 31 → 3 + 1 = 4
            Выполняя редукцию необходимо постоянно держать в уме одно важное правило: если на одном из шагов у вас получилось сочетание цифр 11,22,13,14,16 или 19 то дальнейшее сокращение производить не нужно. Вы получили особенное число.
            """
    }
}
