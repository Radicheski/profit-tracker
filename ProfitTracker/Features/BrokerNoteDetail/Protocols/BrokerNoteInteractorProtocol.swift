//
//  BrokerNoteDetailInteractorProtocol.swift
//  finance
//
//  Created by Erik Radicheski da Silva on 31/01/22.
//

import Foundation

protocol BrokerNoteDetailInteractorProtocol: AnyObject {
    var presenter: BrokerNoteDetailPresenterProtocol { get }
    var worker: BrokerNoteDetailWorkerProtocol { get }
    func loadData()
    func insertTransaction()
    func save()
}
