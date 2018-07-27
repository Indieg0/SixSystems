//
//  MasterTableViewCell.swift
//  DriveNow
//
//  Created by Kirill Konovalov on 27.07.2018.
//  Copyright © 2018 SixSystems. All rights reserved.
//

import UIKit

class MasterTableViewCell: UITableViewCell {
    
    //MARK: - ViewModel
    struct ViewModel {
        let name: String
        let model: String
        let fuelType: FuelType?
    }
    
    //MARK: - Public Properties
    var viewModel: ViewModel? {
        didSet {
            setupUI(viewModel: viewModel)
        }
    }

    //MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var fuelTypeImageView: UIImageView!
    
    //MARK: - Private Methods
    func setupUI(viewModel: ViewModel?) {
        nameLabel.text = viewModel?.name
        modelLabel.text = viewModel?.model
        fuelTypeImageView.image = viewModel?.fuelType?.image
    }
    
}
