//
//  ListSlider.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/11/23.
//

import SwiftUI
class ViewModel: ObservableObject {
    var items = [0,1,2,3,4,5]
}

struct ListSlider: View {
    @ObservedObject var viewModel = ViewModel()
    @State var selection: Bool? = false
    @State var itemIndex = 0
    
    var body: some View {
        NavigationView {
            VStack {
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
    }
}

struct ListSlider_Previews: PreviewProvider {
    static var previews: some View {
        ListSlider()
    }
}
