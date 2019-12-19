//
//  ElementCell.swift
//  Elements
//
//  Created by Christian Hurtado on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementCell: UITableViewCell{

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    var threeDigCode = ""
    
    func configureCell(for element: Element) {
        idLabel.text = element.number.description
        detailsLabel.text = "\(element.symbol) (\(element.number)) \(element.atomic_mass)"
        
        
        if element.number < 10 {
            threeDigCode = "00\(element.number)"
        } else if element.number < 100 && element.number >= 10 {
            threeDigCode = "0\(element.number)"
        } else {
            threeDigCode = element.number.description
        }
     
        
        let imageURL = "http://www.theodoregray.com/periodictable/Tiles/\(threeDigCode)/s7.JPG"
        
        thumbnailImage.getImage(with: imageURL) { (result) in
            switch result {
                case .failure:
                DispatchQueue.main.sync {
                    self.thumbnailImage.image = UIImage(systemName: "person.fill")
                }
            case .success(let image):
                DispatchQueue.main.sync {
                    self.thumbnailImage.image = image
                }
            }
        }
    }
}
