//
//  WebService.swift
//  tribehired_assessment
//
//  Created by Muhammad Hanif Bin Hasan on 05/11/2020.
//  Copyright © 2020 makro baru. All rights reserved.
//

import Foundation

//Function Web service
final class Webservice {
    
    func fetchAllPost(completionHandler: @escaping ([AllPost]) -> Void) {
        
        let urlString = "\(Urls().WebApiPost)"
        print("Webservice getAllPost ->\(urlString)")
        
        //remove spacing
        let urlNoPercent = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string: urlNoPercent) else { return }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with getAllPost: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print("Error with the response, unexpected status code: \(String(describing: response))")
                    return
            }
            
            guard let data = data else { return }
            //Implement JSON decoding and parsing
            do {
                //Decode retrived data with JSONDecoder and assing type of Article object
                let jSONData = try JSONDecoder().decode([AllPost].self, from: data)
                completionHandler(jSONData)
                
            } catch let jsonError {
                print(jsonError)
            }
        })
        task.resume()
    }
    
    
    func fetchIndividualPost(userId :Int,completionHandler: @escaping (IndividualPost) -> Void) {
        
        let urlString = "\(Urls().WebApiPost)/\(userId)"
        print("Webservice getIndividualPost ->\(urlString)")
        
        //remove spacing
        let urlNoPercent = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string: urlNoPercent) else { return }
        
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetchIndividualPost: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print("Error with the response, unexpected status code: \(String(describing: response))")
                    return
            }
            
            guard let data = data else { return }
            //Implement JSON decoding and parsing
            do {
                //Decode retrived data with JSONDecoder and assing type of Article object
                let jSONData = try JSONDecoder().decode(IndividualPost.self, from: data)
                completionHandler(jSONData)
                
            } catch let jsonError {
                print(jsonError)
            }
        })
        task.resume()
    }
    
    
    func fetchCommentPost(userId :Int,completionHandler: @escaping ([CommentPost]) -> Void) {
        
        let urlString = "\(Urls().WebApiComment)?postId=\(userId)"
        print("Webservice getComment ->\(urlString)")
        
        //remove spacing
        let urlNoPercent = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string: urlNoPercent) else { return }
        
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetchCommentPost: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print("Error with the response, unexpected status code: \(String(describing: response))")
                    return
            }
            
            guard let data = data else { return }
            //Implement JSON decoding and parsing
            do {
                //Decode retrived data with JSONDecoder and assing type of Article object
                let jSONData = try JSONDecoder().decode([CommentPost].self, from: data)
                completionHandler(jSONData)
                
            } catch let jsonError {
                print(jsonError)
            }
        })
        task.resume()
    }
}
