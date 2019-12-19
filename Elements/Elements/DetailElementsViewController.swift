//
//  DetailElementsViewController.swift
//  Elements
//
//  Created by Christian Hurtado on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailElementsViewController: UIViewController {
    
    var element: Element?
    
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var meltingLabel: UILabel!
    @IBOutlet weak var boilingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weightLabel.text = element?.atomic_mass.description
        numberLabel.text = element?.number.description
        symbolLabel.text = element?.symbol
        meltingLabel.text = "Melting: \(element!.melt!)"
        boilingLabel.text = "Boiling: \(element!.boil!)"
        nameLabel.text = element?.name
        backgroundView.alpha = 0.85
        navigationItem.title = element?.name
        
        print(element?.name.lowercased())
        let imageURL = "https://images-of-elements.com/\(element!.name.lowercased()).jpg"
        backgroundView.getImage(with: imageURL) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.sync {
                    self?.backgroundView.image = UIImage(systemName: "person.fill")
                }
            case .success(let image):
                DispatchQueue.main.sync {
                    self?.backgroundView.image = image
                }
            }
        }
    }
    
    
    @IBAction func postFave(_ sender: UIBarButtonItem) {
        
        let favorite = Element(name: element!.name, number: element!.number, symbol: element!.symbol, source: element!.source, atomic_mass: element!.atomic_mass, melt: element?.melt!, boil: element?.boil!, discoveredBy: element?.discoveredBy, id: element?.id, favoritedBy: "Christian Hurtado")
        
        ElementsSearchAPIClient.postFave(elements: favorite) { [weak self, weak sender ] result in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Failed to Favorite Element", message: "\(appError)")
                }
            case .success:
                DispatchQueue.main.async {
                    self?.showAlert(title: "Success!", message: "Element added to Favorites") { alert in
                        self?.dismiss(animated: true)
                    }
                }
            }
        }
    }
}
