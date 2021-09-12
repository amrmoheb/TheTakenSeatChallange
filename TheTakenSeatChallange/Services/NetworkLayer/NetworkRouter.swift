//
//  File.swift
//  MREC
//
//  Created by developer on 06/05/2020.
//  Copyright © 2020 developer. All rights reserved.
//

import Foundation

enum NetworkRouter
{  static let baseURLString = "https://api.github.com/users/JakeWharton/repos?"
    
    case GetRepositorys(Int)
    func GetUrl() -> String {
        var relativePath = ""
        switch self {
        
        case .GetRepositorys(let PageNumber):
            relativePath =  "page=\(PageNumber)&per_page=15"
      
        }
        return NetworkRouter.baseURLString + relativePath
    }
    func GetMethod() -> String {
        switch self {

        case .GetRepositorys:
            return "GET"
        }
    }


  
    
}
