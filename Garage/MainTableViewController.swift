//
//  ViewController.swift
//  Garage
//
//  Created by Dmitry on 02.07.2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var markaName: UILabel!
    @IBOutlet weak var modelName: UILabel!
}

class MainTableViewController: UITableViewController {

    private var carsService = CarsService()
    private var car: [Marka] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private var model: [Model] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carsService.fetchCars { result in
            switch result {
            case .success(let car):
                self.car = car
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return car.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomTableViewCell else {
            return .init()
        }
        
        let auto = car[indexPath.row]
        let model = model[indexPath.row]
        cell.markaName.text = auto.name
        cell.modelName.text = model.model
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addNewCar(_ sender: Any) {
        Garage.addNewCar()
        tableView.reloadData()
    }
    
}
