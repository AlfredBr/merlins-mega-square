//
//  HeadingView.swift
//  clear-the-grid
//
//  Created by Alfred Broderick on 6/17/20.
//  Copyright © 2020 Alfred Broderick. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    @Binding var showSettingsView : Bool
    var body: some View {
        Button(action: {
            self.showSettingsView.toggle()
        })
        {
            Image("MerlinsMegaSquare (Header)")
                .resizable(capInsets: EdgeInsets(top: 0.0,
                                                 leading: 0.0,
                                                 bottom: 0.0,
                                                 trailing: 0.0),
                           resizingMode: .stretch)
                .aspectRatio(contentMode: .fit)
                .frame(width: Screen.width)
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(showSettingsView: .constant(false))
    }
}
