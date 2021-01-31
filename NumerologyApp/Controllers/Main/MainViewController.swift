//
//  MainViewController.swift
//  NumerologyApp
//
//  Created by Tetiana on 12.01.2021.
//

import UIKit
extension MainViewController {
    struct Props {
        
        let state: MainScreenState; enum MainScreenState {
            case initial
            case calculated
        }
        let insertLabelText: String
        let enteredString: String?
        let resultLabelText: String
        let result: String
        let btnTitle: String
        let descriptionText: String
        
        let infoAction: Command
        let calculateAction: Command
        let changeTextAction: CommandWith<String?>
        
        static let initial: Props = .init(
            state: .initial,
            insertLabelText: "",
            enteredString: nil,
            resultLabelText: "",
            result: "",
            btnTitle: "",
            descriptionText: "",
            infoAction: .nop,
            calculateAction: .nop,
            changeTextAction: .nop
        )
    }
}

final class MainViewController: UIViewController {
    var viewModel: MainViewModelType!
    private var props: Props = .initial

    @IBOutlet private var insertLabel: UILabel!
    @IBOutlet private var resultTitle: UILabel!
    @IBOutlet private var insertTextField: UITextField!
    @IBOutlet private var resultLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var infoBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()

        viewModel.didLoadData = { props in
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.render(props)
            }
        }
    }

    func render(_ props: Props) {
        self.props = props
        insertLabel.text = props.insertLabelText
        insertTextField.text = props.enteredString
        resultTitle.text = props.resultLabelText

        resultLabel.text = props.result
        
        switch props.state {
        case .initial:
            descriptionLabel.text = ""
            resultLabel.text = ""
        case .calculated:
            descriptionLabel.text = props.descriptionText
            resultLabel.text = props.result
        }
        
        self.view.setNeedsLayout()
    }
    
    private func setup() {
        insertTextField.addTarget(self, action: #selector(didTextChanged), for: .editingChanged)
        insertTextField.delegate = self
    }
    
    @IBAction func calculateBtnAction(_ sender: UIButton) {
        view.endEditing(true)
        props.calculateAction.perform()
    }
    
    @IBAction func infoBtnAction(_ sender: UIButton) {
        props.infoAction.perform()
    }
    
    @objc
    func didTextChanged(_ sender: UITextField) {
        props.changeTextAction.perform(with: sender.text)
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        props.calculateAction.perform()
        return false
    }
}
