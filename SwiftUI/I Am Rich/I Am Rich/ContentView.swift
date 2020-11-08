//
//  ContentView.swift
//  I Am Rich
//
//  Created by brandon on 2020-10-30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color(.systemYellow)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                Text("I Am Rich")
                .font(.system(size: 40))
                .fontWeight(.bold)
                .foregroundColor(Color.purple)
                .multilineTextAlignment(.center)
                    .padding()
                Image("diamond").resizable().aspectRatio(contentMode: .fit).frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
    }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 11")
    }
}
