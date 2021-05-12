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
        self.tableView.register(cellType: CustomCell.self)
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
    
    fileprivate func kehfbhwebfbhe(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CustomCell.self)
        let data = tableData[indexPath.row]
        cell.resetData(data: data, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return kehfbhwebfbhe(tableView, indexPath)
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            tableView.deselectRow(at: indexPath, animated: true)
            tableView.beginUpdates()
            var allIndexPaths = [IndexPath]()
            for index in 0...indexPath.row {
                allIndexPaths.append(.init(row: index, section: 0))
            }
            self.tableData.removeSubrange(0...indexPath.row)
            tableView.deleteRows(at: allIndexPaths, with: .fade)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                tableView.reloadSections(IndexSet(integer: 0), with: .none)
            }
            
            tableView.endUpdates()
        }
//        tableView.visibleCells.forEach { cell in
//            guard let cell = cell as? CustomCell,
//                  let indexPath = tableView.indexPath(for: cell) else { return }
//            let data = self.tableData[indexPath.row]
//            kehfbhwebfbhe(tableView, indexPath)
////            cell.resetData(data: data, indexPath: indexPath)
//        }
    }
    // MARK: - View Data
    struct TableContents {
        var color: UIColor = .random()
        var index: Int
    }
    
    private func generateData() {
        (0...100).forEach { i in
            tableData.append(.init(index: i + 100))
        }
    }
    
    class CustomCell: UITableViewCell {
        func resetData(data: TableContents, indexPath: IndexPath) {
            textLabel?.text = "Index - \(data.index) - row \(indexPath.row)"
            backgroundColor = data.color
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

