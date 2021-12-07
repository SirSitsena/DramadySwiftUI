//
//  LyricsPage.swift
//  Dramady
//
//  Created by User on 23.11.2021.
//

import SwiftUI

struct LyricsPage: View {
    //@ObservedObject var apiModel: ApiModel
    @State var lyrics = String()
    @State var isStarted = false
    @State var artist: String = ""
    @State var title: String = ""
    var body: some View {
        VStack {
            if isStarted == false {
                TextField("Artist", text: $artist)
                TextField("Title", text: $title)
                Button("Search", action: {
                    //apiModel.SearchSong(artist: artist, title: title)
                    //apiModel.SearchLyrics(artist: artist, title: title)
                    isStarted = true
                })
            } else {
                Text(lyrics)
                    .task {
                        Api().load(artist: artist, title: title) { (songSearch) in
                            self.lyrics = songSearch.lyrics
                        }
                    }
            }
            
        }
//        .onChange(of: api.remote!.isLoading, perform: {newValue in
//            //
//            if newValue == false {
//                //Do
//                isLoaded.toggle()
//            }
//        })
    }
}

struct LyricsPage_Previews: PreviewProvider {
    static var previews: some View {
        LyricsPage()
    }
}
