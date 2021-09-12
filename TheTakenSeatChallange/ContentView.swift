//
//  ContentView.swift
//  TheTakenSeatChallange
//
//  Created by Mac on 9/7/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = RepoViewModel()
    @State private var NextPage : Int = 1
    @State private var loadingnewdata = false
    @State private var downloaded = 0.0
    @State private var isAlert = false

   // @FetchRequest(entity: LocalRepository.entity(), sortDescriptors: []) var LocalRepos: FetchedResults<LocalRepository>
  //  @Environment(\.managedObjectContext) var moc

    init() {
        viewModel.SetupCoreData()
        viewModel.perform(pageNumber: NextPage)
    }
    var body: some View {
        Text("")
             .alert(isPresented: Binding<Bool>(
                get: { viewModel.isAlert },
                 set: { _ in viewModel.isAlert }
             )) {
                 Alert(title: Text("No internet connection"),
                     message:Text("Cashed data loaded"),
                     dismissButton: .default(Text("OK")))
             }
      
      List(viewModel.Repos.indices , id: \.self) { RepoIndex in
            Text(viewModel.Repos[RepoIndex].fullName ?? "Unknown")

                .onAppear(){
                  
                   
                    if RepoIndex == (12 * NextPage)
                    {
                        NextPage += 1
                        viewModel.perform(pageNumber: NextPage)
                        

                    }
                }
        }
     
     
       
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
