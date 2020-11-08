//
//  ContentView.swift
//  OlgaCard
//
//  Created by brandon on 2020-10-30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color(red: 0.16, green: 0.50, blue: 0.73)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                Image("Olga")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 160, height: 140, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 5))
                Text("Olga Rudina")
                    .font(Font.custom("Pacifico-Regular", size: 40))
                    .foregroundColor(Color(red: 1.00, green: 0.92, blue: 0.65))
                    .bold()
                Text("iOS Developer")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                Divider()
                InfoView(text: "+1 647 979 5995", imageName: "phone.fill")
                InfoView(text: "olga_rudina@outlook.com", imageName: "envelope.fill")
            }
           
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


