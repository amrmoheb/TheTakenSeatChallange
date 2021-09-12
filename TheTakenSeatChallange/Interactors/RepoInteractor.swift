//
//  RepoInteractor.swift
//  TheTakenSeatChallange
//
//  Created by Mac on 9/8/21.
//

import Foundation
var networkManger = NetworkLayer()

class RepoInteractor {
    func perform(pageNumber: Int = 1) {
    
        networkManger.GetRequest(Model: Repository.self, RequestConfiq: NetworkRouter.GetRepositorys(pageNumber), completionHandler:   {
           respose,State in
                     //    print(respose)
           switch State
            {
           case .empty:
            print("No Data Found")
              
            return
           case .error(let error):
            print(error)
            return
           case .Success:
            print("Success")
            let repositories = respose as? [Repository]
         
        
           }
            
    })
        }
}
