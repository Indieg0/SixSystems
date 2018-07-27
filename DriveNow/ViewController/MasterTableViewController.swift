//
//  MasterTableViewController.swift
//  DriveNow
//
//  Created by Kirill Konovalov on 27.07.2018.
//  Copyright © 2018 SixSystems. All rights reserved.
//

import UIKit

class MasterTableViewController: UITableViewController {

    //MARK: - Private Constants
    private let downloadService = DownloadService()
    
    private var carsArray: [Car] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        downloadCarList { [weak self] (cars) in
            self?.carsArray = cars
        }
    }
    
    private func setupTableView() {
        tableView.register(MasterTableViewCell.nib, forCellReuseIdentifier: MasterTableViewCell.identifier)
    }
    
    private func downloadCarList(completion: @escaping (([Car]) -> Void)) {
        downloadService.downloadCarList { (cars) in
            guard let cars = cars else {
                return //Handle error
            }
            completion(cars)
        }
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
