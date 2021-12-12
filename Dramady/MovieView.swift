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
        VStack {
            if let mov = movie {
                Text(mov.title)
                    .font(.title)
                Text(mov.year)
                Text(mov.fullTitle)
                Text(mov.image)
                Text(mov.releaseDate)
                Text(mov.runtimeStr)
                Text(mov.plot)
                Text(mov.imDbRating)
                
            }
        }.task {
            Api().fetchFromTitleID(titleId: tId, completion: { (fullMovie) in
                self.movie = fullMovie
            })
        }
    }
}

//struct MovieView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieView()
//    }
//}
