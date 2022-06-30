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
            insertLabelText: Localizationable.Global.insertText.localized,
            enteredString: enteredString,
            resultLabelText: Localizationable.Global.result.localized,
            result: "\(result)",
            btnTitle: Localizationable.Global.calculate.localized,
            descriptionText: getDescription(of: result),
            infoAction: Command { [weak self] in
                guard let self = self else { return }
                self.coordinator.showAlert(title: Localizationable.Global.info.localized, message: self.getInfo())
            },
            calculateAction: Command { [weak self] in
                self?.calculate()
                self?.screenState = .calculated
                self?.updateProps()
            },
            changeTextAction: CommandWith { [weak self] text in
                self?.enteredString = text
                self?.updateProps()
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
            return Localizationable.Numerology.numerologyDescription0.localized
        case 1:
            return Localizationable.Numerology.numerologyDescription1.localized
        case 2:
            return Localizationable.Numerology.numerologyDescription2.localized
        case 3:
            return Localizationable.Numerology.numerologyDescription3.localized
        case 4:
            return Localizationable.Numerology.numerologyDescription4.localized
        case 5:
            return Localizationable.Numerology.numerologyDescription5.localized
        case 6:
            return Localizationable.Numerology.numerologyDescription6.localized
        case 7:
            return Localizationable.Numerology.numerologyDescription7.localized
        case 8:
            return Localizationable.Numerology.numerologyDescription8.localized
        case 9:
            return Localizationable.Numerology.numerologyDescription9.localized
        default:
            return Localizationable.Numerology.incorrectAlgorythm.localized
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
        return Localizationable.Global.appInfoText.localized
    }
}
