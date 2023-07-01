//
//  ViewController.swift
//  HomeWorkCodable
//
//  Created by Dmitry on 18.06.2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    //@IBOutlet weak var preViewImageView: UIImageView!
    @IBOutlet weak var markaLabel: UILabel!
}

class CarsViewController: UITableViewController {
    
    private let carsService = CarsService()
    private var cars: [Car] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private weak var activity: UIActivityIndicatorView?
    
    @IBAction func addNewCar(_ sender: Any) {
        guard let url = URL(string: "https://my-json-server.typicode.com/iDmitry89/HomeWorkCodable/data") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let newMarka = Car(id: 55, name: "HUMMER")
        
        do {
            let jsonBody = try JSONEncoder().encode(newMarka)
            request.httpBody = jsonBody
        } catch {
            
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) {
            (data,_,_) in
            guard let data = data else { return }
            do {
                let sendPost = try JSONDecoder().decode(Car.self, from: data)
                print(sendPost)
            } catch {
                
            }
        }
        task.resume()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let activity = UIActivityIndicatorView(style: .medium)
        //        activity.sizeToFit()
        //        activity.hidesWhenStopped = true
        //        self.activity = activity
        //
        //        let buttonItem = UIBarButtonItem(customView: activity)
        //        navigationItem.rightBarButtonItem = buttonItem
        //
        //        activity.startAnimating()
        carsService.fetchCars { result in
            //self.activity?.stopAnimating()
            switch result {
            case .success(let cars):
                self.cars = cars
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomTableViewCell else {
            return .init()
        }
        
        let auto = cars[indexPath.row]
        cell.markaLabel.text = "\(auto.name)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "segueToDetail" {
    //            if let indexPath = tableView.indexPathForSelectedRow {
    //                let destinationController = segue.destination as! ModelsViewController
    //                    destinationController.auto = cars
    //            }
    //        }
    //    }
    
}
