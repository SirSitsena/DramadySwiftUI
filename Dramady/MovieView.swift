//
//  MovieView.swift
//  Dramady
//
//  Created by User on 22.11.2021.
//

import SwiftUI

struct MovieView: View {
    @State var movie: FullMovie?
    let tId: String
    var body: some View {
        List{
            VStack {
                if let mov = movie {
                    Text(mov.title)
                        .font(.title)
                    AsyncImage(url: URL(string: mov.image)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 200, height: 200, alignment: .leading)
                        } else if phase.error != nil {
                            Color.red
                        } else {
                            ProgressView()
                            //Color.blue
                        }
                    }
                    .padding(.bottom, 15)
                    Text("Year: \(mov.year)")
                        .padding(.bottom, 15)
                    Text("Imdb rating: \(mov.imDbRating)")
                    .padding(.bottom, 15)
                    Text("Movie length: \(mov.runtimeStr)")
                        .padding(.bottom, 15)
                    Text(mov.plot)
                    
                }
            }.task {
                Api().fetchFromTitleID(titleId: tId, completion: { (fullMovie) in
                    self.movie = fullMovie
                })
            }
        }.frame(
            minHeight: 810,
            maxHeight: .infinity,
            alignment: .center
        )
        
    }
}

//struct MovieView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieView()
//    }
//}
