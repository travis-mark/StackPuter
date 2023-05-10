//
//  ContentView.swift
//  StackPuter
//
//  Created by Travis Luckenbaugh on 5/9/23.
//

import SwiftUI

func eval(_ forms: String) -> [String] {
    return forms.split(separator: " ").map { $0.description }
}

struct ContentView: View {
    @State var form: String = ""
    var body: some View {
        VStack {
            TextField("Type formula here", text: $form)
            Spacer()
            ForEach(eval(form), id: \.self) { item in
                HStack {
                    Text(item)
                    Spacer()
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
