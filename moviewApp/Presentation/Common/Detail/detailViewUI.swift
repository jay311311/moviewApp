//
//  detailViewUI.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/11/30.
//

import SwiftUI

struct detailViewUI: View {
    
    @EnvironmentObject var detailViewModel : DetailViewModel
    
    
    var body: some View {
        Text("\(detailViewModel.title)")
    }
}

struct detailViewUI_Previews: PreviewProvider {
    static var previews: some View {
        detailViewUI()
    }
}

