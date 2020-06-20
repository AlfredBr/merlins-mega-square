//
//  SegmentedPickerView.swift
//  clear-the-grid
//
//  Created by Alfred Broderick on 6/18/20.
//  Copyright © 2020 Alfred Broderick. All rights reserved.
//

import SwiftUI

struct SimplePickerView: View {
    var prompt:String
    var options:[String]
    @State var selectedIndex = 0

    var body: some View {
        VStack (spacing: 10.0) {
            Text(prompt)
                .font(Font.title)
                .padding(.vertical, 5).padding(.horizontal, 8)
                .background(Color.gray)
                .foregroundColor(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
            Picker(selection: $selectedIndex, label: Text(prompt)) {
                ForEach(0 ..< options.count) { i in
                    Text(options[i]).font(Font.title)
                }
            }
            .labelsHidden()
           
        }
    }
}

struct FormPickerView: View {
    var prompt:String
    var options:[String]
    @Binding var selectedIndex:Int?
    
    var body: some View {
        Form {
            Picker(self.prompt, selection: self.$selectedIndex) {
                ForEach(0 ..< options.count) { i in
                    Text(self.options[i]).font(Font.title)
                }
            }
        }
    }
}
