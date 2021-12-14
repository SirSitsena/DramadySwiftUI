//
//  PopularPage.swift
//  Dramady
//
//  Created by User on 22.11.2021.
//
//(Color.parseColor("#7878AB")
//backgroundColor: 7878AB

import SwiftUI

struct PopularPage: View {
    @State private var movies = [popularMovie]()
    
    @State public var intStatus = false
    
    func status(){
        monitor.pathUpdateHandler = { pathUpdateHandler in
                   if pathUpdateHandler.status == .satisfied {
                       intStatus = true
                       print("Internet connection is on.")
                   } else {
                       intStatus = false
                       print("There's no internet connection.")
                   }
               }
               monitor.start(queue: queue)
    }
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Popular Movies")
                    .font(.title).bold().italic()
                    .foregroundColor(.yellow)
            List(movies, id: \.id) {movie in
                NavigationLink(destination: MovieView(tId: movie.id)) {
                        HStack{
                            AsyncImage(url: URL(string: movie.image)) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .frame(width: 50, height: 50, alignment: .leading)
                                } else if phase.error != nil {
                                    ProgressView()
                                } else {
                                    ProgressView()
                                }
                            }
                            
                            Text(movie.title)
                                .foregroundColor(.white)
                            Text(movie.rank)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                }
            }
            .padding(.top, 0)
            .listStyle(InsetGroupedListStyle())
            .colorScheme(.dark)
            .task {
                intStatus = false
                status()
                if intStatus == true{
                    Api().fetchPopular { (popularMovie) in
                        self.movies = popularMovie.items
                        intStatus = false
                    }
                } else {
                    status()
                }
            }
            }
        }
        
        .background(Color.black)
        .frame(minHeight: screenHeight)
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}


struct PopularPage_Previews: PreviewProvider {
    static var previews: some View {
        PopularPage()
    }
}
