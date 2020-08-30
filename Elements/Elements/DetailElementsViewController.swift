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
        meltingLabel.text = "Melting: \(element?.melt ?? 0.0)"
        boilingLabel.text = "Boiling: \(element?.boil ?? 0.0)"
        nameLabel.text = element?.name
        backgroundView.alpha = 0.85
        navigationItem.title = element?.name
        
//        print(element?.name.lowercased())
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
        
        let favorite = Element(name: element?.name ?? "no name", number: element?.number ?? 0, symbol: element?.symbol ?? "no symbol", source: element?.source ?? "no source", atomic_mass: element?.atomic_mass ?? 0.0, melt: element?.melt ?? 0.0, boil: element?.boil ?? 0.0, discoveredBy: element?.discoveredBy, id: element?.id, favoritedBy: "Christian Hurtado")
        
        ElementsSearchAPIClient.postFave(elements: favorite) { [weak self] result in
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
