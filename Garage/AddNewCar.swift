//
//  AddNewCar.swift
//  Garage
//
//  Created by Dmitry on 02.07.2023.
//

import Foundation

func addNewCar() {
    guard let url = URL(string: "https://my-json-server.typicode.com/iDmitry89/HomeWorkCodable/db") else {
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let newMarka = Marka(id: 55, name: "KIA", model: Model(id: 55, model: "Mohave"))
    
    guard let jsonBody = try? JSONEncoder().encode(newMarka) else {
        return
    }
        request.httpBody = jsonBody

    let _ = URLSession.shared.uploadTask(with: request, from: jsonBody) { data, response, error in
        if let error = error {
            print ("error: \(error)")
            return
        }
        guard let response = response as? HTTPURLResponse,
            (200...299).contains(response.statusCode) else {
            print ("Server error")
            return
        }
        if let mimeType = response.mimeType,
            mimeType == "application/json",
            let data = data,
           let dataString = String(data: data, encoding: .utf8) {
            print ("got data: \(dataString)")
        }
    }

    let sessionGet = URLSession.shared
    let task = sessionGet.dataTask(with: request) {
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
