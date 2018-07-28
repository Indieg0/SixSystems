//
//  MasterTableViewController.swift
//  DriveNow
//
//  Created by Kirill Konovalov on 27.07.2018.
//  Copyright © 2018 SixSystems. All rights reserved.
//

import UIKit

class MasterTableViewController: UITableViewController, CarProcessable {

    //MARK: - CarProcessable
    let downloadService = DownloadService()
    
    //MARK: - Private Properties
    private var carsArray: [Car] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        downloadCarList { [weak self] (cars) in
            self?.carsArray = cars
        }
    }

    //MARK: - Private Methods
    private func setupTableView() {
        tableView.register(MasterTableViewCell.nib, forCellReuseIdentifier: MasterTableViewCell.identifier)
    }

    //MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MasterTableViewCell.identifier, for: indexPath) as! MasterTableViewCell
        let currentCar = carsArray[indexPath.row]
        cell.viewModel = MasterTableViewCell.ViewModel(name: currentCar.name,
                                                       model: currentCar.modelName,
                                                       fuelType: currentCar.fuelType)
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCar = carsArray[indexPath.row]
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.carModel = currentCar
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
