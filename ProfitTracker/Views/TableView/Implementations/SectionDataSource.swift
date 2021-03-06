//
//  SectionDataSource.swift
//  finance
//
//  Created by Erik Radicheski da Silva on 30/01/22.
//

import UIKit

class SectionDataSource: NSObject {

    private var sections: [Section] = []
    var count: Int { self.sections.count }

    func register(in tableView: UITableView) {
        self.sections.forEach { $0.register(in: tableView) }
    }

    func numberOfRows(for section: Int) -> Int {
        return self.sections[section].rowCount
    }

    func dataSource(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.sections[indexPath.section].row(for: tableView, at: indexPath)
    }

    private func getSection(forKey key: String) -> Section? {
        return self.sections.first { $0.key == key }
    }

    private func getSectionIndex(forkey key: String) -> Int? {
        return self.sections.firstIndex { $0.key == key }
    }

    func getRow(fromSection sectionKey: String, withKey rowKey: String) -> Row? {
        guard let section = getSection(forKey: sectionKey) else { return nil }
        return section.rows.first { $0.key == rowKey }
    }

}

extension SectionDataSource: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.sections[indexPath.section].rows[indexPath.row].didSelect?(tableView, indexPath)
    }

}

extension SectionDataSource: UITableViewDataSource {

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return self.sections[indexPath.section].canMoveRow(for: tableView, at: indexPath.row)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return self.sections[indexPath.section].canEditRow(for: tableView, at: indexPath.row)
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.sections[section].footerTitle
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section].headerTitle
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.sections[indexPath.section].row(for: tableView, at: indexPath)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].rowCount
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }

}

// MARK: Row related functions

extension SectionDataSource {

    func insert(row: Row, forSectionKey key: String, at index: Int) {
        let section = self.getSection(forKey: key)
        section?.insert(row: row, at: index)
    }

    func insert(row: Row, forSectionKey key: String, after rowKey: String) {
        let section = self.getSection(forKey: key)
        section?.insert(row: row, after: rowKey)
    }

    func insert(row: Row, forSectionKey key: String, before rowKey: String) {
        let section = self.getSection(forKey: key)
        section?.insert(row: row, before: rowKey)
    }

    func deleteRow(forSectionKey key: String, at index: Int) {
        let section = self.getSection(forKey: key)
        _ = section?.removeRow(at: index)
    }

    func deleteRow(forSectionKey key: String, rowKey: String) {
        let section = self.getSection(forKey: key)
        _ = section?.removeRow(withKey: rowKey)
    }

    func moveRow(forSectionKey key: String, from sourceIndex: Int, to targetIndex: Int) {
        let section = self.getSection(forKey: key)
        section?.moveRow(from: sourceIndex, to: targetIndex)
    }

}

// MARK: Section related functions

extension SectionDataSource {

    func setSections(_ sections: [Section]) {
        self.sections = sections
    }

    func insert(section: Section, at index: Int) {
        self.sections.insert(section, at: index)
    }

    func insert(section: Section, after sectionKey: String) {
        if let index = self.getSectionIndex(forkey: sectionKey) {
            self.sections.insert(section, at: index + 1)
        }
    }

    func insert(section: Section, before sectionKey: String) {
        if let index = self.getSectionIndex(forkey: sectionKey) {
            self.sections.insert(section, at: index)
        }
    }

    func deleteSection(at index: Int) {
        self.sections.remove(at: index)
    }

    func deleteSection(forKey key: String) {
        self.sections.removeAll(where: { $0.key == key })
    }

    func moveSection(from sourceIndex: Int, to targetIndex: Int) {
        let section = self.sections.remove(at: sourceIndex)
        self.sections.insert(section, at: targetIndex)
    }

}
