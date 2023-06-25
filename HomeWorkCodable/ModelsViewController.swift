//
//  modelsViewController.swift
//  HomeWorkCodable
//
//  Created by Dmitry on 25.06.2023.
//

import Foundation
import UIKit

class DetailCustomTableViewCell: UITableViewCell {
    @IBOutlet weak var modelLabel: UILabel!
}

class ModelsViewController: UITableViewController {
    
    private let modelsService = ModelsService()
    private var models: [Model] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modelsService.fetchModels { result in
            switch result {
                case .success(let models):
                    self.models = models
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell2 = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as? DetailCustomTableViewCell else {
            return .init()
        }
        
        cell2.modelLabel.text = "\(models[indexPath.row].name)"
        
        return cell2
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
