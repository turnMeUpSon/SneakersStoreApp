//
//  ContentView.swift
//  SneakersStoreIOS
//
//  Created by Ian Miller on 19.02.2024.
//

import SwiftUI

struct ContentView: View {
    @State var segment_index = 0
    @State var offset_x = 0
    @State var selected_size = "9"
    @State var selected_color = "White"
    
    var companies = ["Nike", "Puma", "Adidas"]
    var sneakers = ["nike", "puma", "adidas"]
    var sizes = ["7", "8", "9", "10", "11"]
    var colors = ["White", "Black", "Red", "Blue", "Green"]
    
    var body: some View {
        VStack {
            Text("Sneackers - \(companies[segment_index])").font(Font.system(.title))
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray)
                    .padding()
                    .offset(x: CGFloat(offset_x))
                Image(sneakers[segment_index])
                    .resizable()
                    .frame(width: 300, height: 300)
                    .offset(x: CGFloat(offset_x))
            }.animation(.spring())
            
            Picker("Choose a brand", selection: Binding(get: {
                self.segment_index
            }, set: {
                new_value in self.segment_index = new_value
                self.offset_x = -500
                self.move_back()
            })) {
                ForEach(companies.indices, id: \.self) { index in
                    Text(self.companies[index]).tag(index)
                }
            }.pickerStyle(SegmentedPickerStyle()).padding()
            
            Picker("Choose a size", selection: $selected_size) {
                ForEach(sizes, id: \.self) { size in
                    Text(size).tag(size)
                }
            }.pickerStyle(SegmentedPickerStyle()).padding()
            
            Picker("Choose a color", selection: $selected_color) {
                ForEach(colors, id: \.self) { color in
                    Text(color).tag(color)
                }
            }.pickerStyle(SegmentedPickerStyle()).padding()
            
            Button(action: {
                print("Buy \(companies[segment_index]) sneakers")
            }) {
                Text("Buy \(companies[segment_index]) Sneakers")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(10)
            }.padding()
        }
    }
    
    private func move_back() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.offset_x = 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
