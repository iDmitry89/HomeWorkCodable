//
//  AddNewCar.swift
//  Garage
//
//  Created by Dmitry on 02.07.2023.
//

import Foundation

func addNewCar() {
    guard let url = URL(string: "https://my-json-server.typicode.com/iDmitry89/HomeWorkCodable/data") else {
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    let newMarka = Marka(id: 55, name: "KIA", model: Model(id: 55, model: "Mohave"))
    
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
            let sendPost = try JSONDecoder().decode(Marka.self, from: data)
            print(sendPost)
        } catch {
            
        }
    }
    task.resume()
}
