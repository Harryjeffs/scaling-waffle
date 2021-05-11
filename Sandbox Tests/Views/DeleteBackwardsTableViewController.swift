//
//  DeleteBackwardsTableViewController.swift
//  Sandbox Tests
//
//  Created by Harry Jeffs on 11/5/21.
//

import UIKit

class DeleteBackwardsTableViewController: UITableViewController {

    private var tableData: [TableContents] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(cellType: UITableViewCell.self)
        self.title = "Delete Test"
        
        // Data generation
        generateData()
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UITableViewCell.self)
        let data = tableData[indexPath.row]
        cell.textLabel?.text = "Index - \(data.index) - row \(indexPath.row)"
        cell.backgroundColor = data.color
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.beginUpdates()
        var allIndexPaths = [IndexPath]()
        for index in 0...indexPath.row {
            allIndexPaths.append(.init(row: index, section: 0))
        }
        tableData.removeSubrange(0...indexPath.row)
        tableView.deleteRows(at: allIndexPaths, with: .fade)
        tableView.endUpdates()
//        tableView.reloadData()
        
    }
    // MARK: - View Data
    private struct TableContents {
        var color: UIColor = .random()
        var index: Int
    }
    
    private func generateData() {
        (0...100).forEach { i in
            tableData.append(.init(index: i))
        }
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red:   .random(),
            green: .random(),
            blue:  .random(),
            alpha: 1.0
        )
    }
}
