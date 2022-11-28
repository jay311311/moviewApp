//
//  ListSlider.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/11/23.
//

import SwiftUI
import RxFlow
import RxCocoa
import RxSwift

class MovieData: ObservableObject {
    @Published var movieList:[AllInfo] = []
}
class ViewModel: ObservableObject {
    var items = [0,1,2,3,4,5]
}
struct ListSlider: View {
    var weeklyMovieSlide = BehaviorRelay<[AllInfo]>(value: [])
    var actionRelay = PublishRelay<HomeActionType>()
    let disposeBag = DisposeBag()
    
    @EnvironmentObject  private var movieInfo: MovieData
    @State var viewModel =  ViewModel()
    @State private var selection: Bool? = false
    @State private var itemIndex = 0
    
    func setupDI(relay: PublishRelay<HomeActionType>) {
        actionRelay.bind(to: relay).disposed(by: disposeBag)
    }
    func setupDI(observable: BehaviorRelay<[AllInfo]>) {
        observable.bind(to: weeklyMovieSlide).disposed(by: disposeBag)
    }
    
    var body: some View {
        ScrollView(.horizontal){
            HStack {
                ForEach(self.viewModel.items, id: \.self) { row in
                    HStack {
                        
                        Text(String(row))
                            .frame(width: 180, height: 200)
                            .background(Color.green)
                            .onTapGesture {
                                self.selection = true
                                self.itemIndex = row
                            }
                        
                    }
                }
            }
        }
    }
}

struct ListSlider_Previews: PreviewProvider {
    static var previews: some View {
        ListSlider()
    }
}
