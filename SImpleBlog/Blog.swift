//
//  Blog.swift
//  SImpleBlog
//
//  Created by ardMac on 27/04/2017.
//  Copyright © 2017 ardMac. All rights reserved.
//

import Foundation

class Blog {
    
    let blogID : String
    var title : String = ""
    var body : String?
    
    init?(dictionary: [String : Any]) {
        
        guard let validID = dictionary["id"] as? Int else { return nil }
        //blogID = validID
        blogID = String(validID)
        title = dictionary["title"] as? String ?? ""
        body = dictionary["body"] as? String
        
    }
}
