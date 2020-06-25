//
//  ButtonImageView.swift
//  clear-the-grid
//
//  Created by Alfred Broderick on 6/23/20.
//  Copyright © 2020 Alfred Broderick. All rights reserved.
//

import SwiftUI

struct ButtonImageView: View {
    var imageName : String
    @Environment(\.colorScheme) var colorScheme
    
    var randomRotation : Double {
        return Double.random(in: -45 ... +45)
    }
    
    var randomAngle : Angle {
        return Angle(degrees: randomRotation)
    }
    
    var randomOffset : CGSize {
        return CGSize(width: Int.random(in: -70 ..< +70),
                      height: Int.random(in: -180 ..< +180))
    }
    
    var body: some View {
        ZStack {

            ForEach(0 ..< 20, id: \.self)
            {
                _ in
                OffsetShape(
                    shape: RotatedShape(
                        shape: RoundedRectangle(cornerRadius: 16.0),
                        angle: self.randomAngle,
                        anchor: .center),
                        offset: self.randomOffset)
                    .fill(Color.random)
                    .frame(width: Screen.width/2, height: Screen.height/6)
                    .blur(radius: 3)
            }
            Image(imageName)
                .resizable(capInsets: EdgeInsets(top: 0.0,
                                                 leading: 0.0,
                                                 bottom: 0.0,
                                                 trailing: 0.0),
                           resizingMode: .stretch)
                .aspectRatio(contentMode: .fit)
                .frame(width: Screen.width/2, height: Screen.height/6)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .circular))
                .shadow(color: Color(red: 0, green: 0, blue: 0),
                radius: 10, x: 5, y: 5)

        }
    }
}

struct ButtonImageView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonImageView(imageName: "Winner1")
    }
}
