//
//  NetworkLayer.swift
//  MREC
//
//  Created by developer on 07/05/2020.
//  Copyright © 2020 developer. All rights reserved.
//

import Foundation
class NetworkLayer {
    
    private var observation: NSKeyValueObservation?

       var AnyModel :Any!
    typealias CompletionHandler = (Any,RemoteResponseState) -> Void
    init() {
        
    }
    //swicher
    func Request<T>( ResponseModel: T.Type,RequestConfiq: NetworkRouter,completionHandler: @escaping  CompletionHandler) where T: Decodable
    {
        switch RequestConfiq.GetMethod() {
      
      case "Get":
             GetRequest(Model: ResponseModel, RequestConfiq: RequestConfiq, completionHandler: completionHandler)
              print("Get Request Proceed")
  
        default:
            print("No Method setted")
        }
    }
    public  func GetRequest<T:Decodable>( Model: T.Type,RequestConfiq: NetworkRouter,completionHandler: @escaping  CompletionHandler)
      {
        print(RequestConfiq.GetUrl())
        let url = URL(string: RequestConfiq.GetUrl())!

        var request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
             //   let image = UIImage(data: data)
                print("Success")
                if data == nil
                          {
                              print("NoData")
                           completionHandler(self.AnyModel,.empty)
                            return
                          }
            
        //self.AnyModel =  try! JSONDecoder().decode(NewsSearchResponse.self, from: data.data!)

                self.AnyModel =  try!  JSONDecoder().decode(Model.self, from: data)

            do{
            //    print(<#T##items: Any...##Any#>)
                self.AnyModel =  try  JSONDecoder().decode(Model.self, from: data)

                completionHandler(self.AnyModel,.Success)

           }


           catch{


               print("error in parsssssing")
            completionHandler(self.AnyModel,.error("error in parsssssing"))

           }
      
            } else if let error = error {
                completionHandler(self.AnyModel,.error("cant connect to server"))

                print("HTTP Request Failed \(error)")
            }
        }
        observation = task.progress.observe(\.fractionCompleted) { progress, _ in
            print("progress: ", progress.completedUnitCount )
          }
        task.resume()
    /*    let request = AF.request(RequestConfiq.GetUrl())
       // var utf8Text = ""
        
       request.responseJSON
        {
            data  in
         
            print(RequestConfiq.GetUrl())
            print("mydata")
            print(data)
                print(Model)
          
            switch data.result {
            case .failure(let error):
             // self.NetworkErrorHandle(ErrorMessage :" Check your Internet Connection ")
               print(error)
                completionHandler(self.AnyModel,.error("cant connect to server"))
              return
                // Do your code here...

            case .success(_):
                print("Success")
                if data.data == nil
                          {
                              print("NoData")
                           completionHandler(self.AnyModel,.empty)
                            return
                          }
            }
        //self.AnyModel =  try! JSONDecoder().decode(NewsSearchResponse.self, from: data.data!)


            do{
            //    print(<#T##items: Any...##Any#>)
                self.AnyModel =  try  JSONDecoder().decode(Model.self, from: data.data!)


           }


           catch{


               print("error in parsssssing")
            completionHandler(self.AnyModel,.error("error in parsssssing"))

           }
           
        //    MinValue = self.Intro.MinYesToPass!
        //print(self.Intro.MinYesToPass)
            completionHandler(self.AnyModel,.Success)
      }
     
     //   return MinValue
        */
    }
    
    

}
