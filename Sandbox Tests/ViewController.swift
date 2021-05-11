//
//  ViewController.swift
//  Sandbox Tests
//
//  Created by Harry Jeffs on 11/5/21.
//

import UIKit

class HomeViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Sandbox Home"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(cellType: UITableViewCell.self)
    }

    // MARK: - Table View Functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        TableContents.allCases.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UITableViewCell.self)
        let data = TableContents.allCases[indexPath.row]
        cell.textLabel?.text = data.rawValue
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigationController = self.navigationController else { return }
        let data = TableContents.allCases[indexPath.row]
        navigationController.pushViewController(data.viewController, animated: true)
    }
    
    // MARK: - View Data
    private enum TableContents: String, CaseIterable {
        case deleteBackwardsTest = "Delete Backwards Test"
        
        var viewController: UIViewController {
            switch self {
            case .deleteBackwardsTest: return DeleteBackwardsTableViewController()
            }
        }
    }
}

extension UITableViewCell: Reusable {}
