//
//  NetworkManager.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 23.01.2023.
//

import Foundation

struct NetworkManager{
    
    enum AppConfiguration: String, CaseIterable {
        
        case people = "https://swapi.dev/api/people/8"
        case starship = "https://swapi.dev/api/starships/3"
        case planets = "https://swapi.dev/api/planets/3"
    }
    
    static func request(for configuration: AppConfiguration) {
        let session = URLSession(configuration: .default)
        let url = URL(string: configuration.rawValue)
        let task = session.dataTask(with: url!) {data, response, error in
            if let error = error{
                print(error.localizedDescription)
            }
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if statusCode != 200 {
                print("StatusCode != 200, statusCode = \(String(describing: statusCode))")
            } else {
                print("StatusCode = \(String(describing: statusCode))")
                
                if let httpHeaderFields = (response as? HTTPURLResponse)?.allHeaderFields["Server"]{
                    print("Server header field =", httpHeaderFields )
                } else {
                    print("Server header field = nil")
                }
                
                if let dateHeaderFields = (response as? HTTPURLResponse)?.allHeaderFields["Date"]{
                    print("Date header field =", dateHeaderFields )
                } else {
                    print("Date header field = nil")
                }
            }
                
            guard let data else {
                print("data = nil")
               return
            }
            do{
                if let answer =  try JSONSerialization.jsonObject(with: data) as? [String: Any],
                    let text = answer["name"] as? String{
                    print("Planet name is",text)
                    return
                }
                
            } catch {
                print(error.localizedDescription)
                
            }
        }
        task.resume()
        }
    }

