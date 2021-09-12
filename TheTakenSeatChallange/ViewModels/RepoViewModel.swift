//
//  RepoViewModels.swift
//  TheTakenSeatChallange
//
//  Created by Mac on 9/8/21.
//

import Foundation
import CoreData
class RepoViewModel:ObservableObject {
    @Published var Repos: [Repository] = [] // 1
    @Published var isAlert = false
     var LocalRepos: [LocalRepository] = [] // 1

    private var moc : NSManagedObjectContext!
    var currentPage = 0
    func SetupCoreData( )  {
        LocalRepos = CoreDataManager.shared.getAllRepositories()
    }
    
    func perform(pageNumber: Int = 1) {
        self.currentPage = pageNumber
        networkManger.GetRequest(Model: [Repository].self, RequestConfiq: NetworkRouter.GetRepositorys(pageNumber), completionHandler:   {
           respose,State in
                     //    print(respose)
           switch State
            {
           case .empty:
            print("No Data Found")
              
            return
           case .error(let error):
            self.isAlert = true
            self.GetLocalData()
            self.CopyLocalData()

            print(error)
            return
           case .Success:
            print("Success")
            let repositories = respose as? [Repository]
         
            if let results  = repositories  {
                DispatchQueue.main.async {   // <====

                self.Repos += results
                    
                    self.GetLocalData()
                    self.SaveRepositories()
                }
            }
           }
            
    })
        }
  
    func GetLocalData()  {
        LocalRepos = CoreDataManager.shared.getAllRepositories()

    }
    func CopyLocalData()  {
        guard  LocalRepos.count > 0 else {
            return
        }
        let startPointer = (currentPage-1)*15
        let endPointer = startPointer+14
        
        guard endPointer < LocalRepos.count else {
            return
        }
        for index in startPointer...endPointer {
            var repoItem = Repository()
            repoItem.fullName = LocalRepos[index].fullName ?? "unknown"
            Repos.append(repoItem)
        }
    }
    func SaveRepositories() {
      
        for index in 0...self.Repos.count-1
        {
            if index >= self.LocalRepos.count {
                var LocalRepoItem = LocalRepository(context: CoreDataManager.shared.viewContext)
                LocalRepoItem.fullName = self.Repos[index].fullName
              
       // CoreDataManager.shared.viewContext.insert(LocalRepoItem)
               // LocalRepos = CoreDataManager.shared.getAllRepositories()
           }
        
        }
        CoreDataManager.shared.save()

    }

}
