//
//  detailViewUI.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/11/30.
//

import SwiftUI

struct detailViewUI: View {
    
    @EnvironmentObject var detailViewModel : DetailViewModel
    @State var scrollOffset: CGFloat = CGFloat.zero

    var body: some View {
        let what  = print(self.detailViewModel.movieInfomation)
        if let movie = detailViewModel.movieInfomation, let url = URL(string: "https://image.tmdb.org/t/p/w400\(movie.poster_path)") {
            ScrollView{
                VStack(alignment:.leading){
                    AsyncImage(url: url, scale: 1.5){ image in
                        image
                    } placeholder: {
                        ProgressView()
                    }.padding(.horizontal)
                    // 로딩되기 전까지 대체할 이미지 혹은 스타일
                    Text("\(movie.status)")
                        .multilineTextAlignment(.leading)
                    Text("\(movie.title)")
                    Text("\(movie.tagline)")
                    Text("\(movie.release_date)")
                    Text("\(movie.runtime)")
                    Text("\(movie.vote_average)")
                    Text("\(movie.overview)")
                }
                .padding([.horizontal])
                Divider()
            }
            
        } else {
            ProgressView()
        }
    }
}

//struct detailViewUI_Previews: PreviewProvider {
//    static var previews: some View {
//        detailViewUI()
//    }
//}
//
