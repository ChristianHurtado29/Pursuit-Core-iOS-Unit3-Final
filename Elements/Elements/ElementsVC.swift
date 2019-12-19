//
//  ViewController.swift
//  Elements
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ElementsVC: UIViewController {
    
    var elements = [Element](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadData(for: elements)
        tableView.reloadData()
    }
    
    func loadData(for elements: [Element]) {
        ElementsSearchAPIClient.getElements(for: elements) {[weak self] (result) in
            switch result {
            case .failure(let appError):
                print("Error \(appError)")
            case .success(let element):
                self?.elements = element.sorted {$0.number < $1.number}
            }
        }
    }
}

extension ElementsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as! ElementCell
        let selElement = elements[indexPath.row]
        cell.configureCell(for: selElement)
        return cell
    }
}

extension ElementsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
