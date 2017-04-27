//
//  BlogApi.swift
//  SImpleBlog
//
//  Created by ardMac on 27/04/2017.
//  Copyright © 2017 ardMac. All rights reserved.
//

import Foundation

class BlogApi {
    
//    GET https://nextacademy-ios-blog.herokuapp.com/api/v1/blogs
    
    static func getAllBlogs(completion: @escaping ([Blog], Error?)->Swift.Void) {
        //create request
        let url = URL(string: "https://nextacademy-ios-blog.herokuapp.com/api/v1/blogs")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let err = error as NSError?{
                print(err.localizedDescription)
                completion([],err)
                return
            }
            guard let validData = data else {return}
            do {
                guard let responseJSON = try JSONSerialization.jsonObject(with: validData, options: []) as? [[String: Any]] else {return}
                
                let allBlogs : [Blog] = responseJSON.map({ rawBlog in
                    
                    let blog = Blog(dictionary: rawBlog)
                    return blog!
                })
                completion(allBlogs, nil)
                
            }catch let jsonError as NSError {
                print(jsonError.localizedDescription)
                completion([],jsonError)
            }
            
            
        }
        dataTask.resume()
        
    }
    
    static func postABlog(dictionary: [String : Any]){
        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        let url = URL(string: "https://nextacademy-ios-blog.herokuapp.com/api/v1/blogs")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonData
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let err = error as NSError?{
                print(err.localizedDescription)
                return
            }
        }
        dataTask.resume()
    }
    
    static func updateABlog(dictionary: [String : Any], id: String){
        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        let url = URL(string: "https://nextacademy-ios-blog.herokuapp.com/api/v1/blogs/\(id)")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "PUT"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonData
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let err = error as NSError?{
                print(err.localizedDescription)
                return
            }
        }
        dataTask.resume()
    }
    
    static func deleteABlog(id : String, completion: @escaping (Error?)->Swift.Void) {
        
        let url = URL(string: "https://nextacademy-ios-blog.herokuapp.com/api/v1/blogs/\(id)")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "DELETE"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let err = error as NSError?{
                print(err.localizedDescription)
                completion(error)
                return
            }
            completion(nil)
            
        }
        dataTask.resume()
    }

    
}
