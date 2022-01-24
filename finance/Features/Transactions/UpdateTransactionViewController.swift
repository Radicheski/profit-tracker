//
//  UpdateTransactionViewController.swift
//  finance
//
//  Created by Erik Radicheski da Silva on 16/01/22.
//

import Foundation

class UpdateTransactionViewController: BaseViewController<UpdateTransactionView> {
    
    var onDismiss: (() -> Void)?
    
    var item: Transaction.ViewModel? {
        didSet { self.updateView() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customView.tickerTextField.delegate = self
        self.customView.quantityTextField.delegate = self
        self.customView.totalTextField.delegate = self
        
        self.customView.navigationBar.saveCancelDelegate = self
    }
    
    func updateView() {
        if let item = item {
            self.customView.dateTextField.date = item.date.value
            self.customView.tickerTextField.placeholder = item.ticker.value
            self.customView.quantityTextField.placeholder = item.quantity.value
            self.customView.totalTextField.placeholder = item.total.value
        }
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag) { [weak self] in
            self?.onDismiss?()
            completion?()
        }
    }
    
}
