//  StackPuter - StackPuterApp.swift
//  Created by Travis Luckenbaugh on 5/9/23.

import SwiftUI

struct ContentView: View {
    @State var form: String = ""
    var body: some View {
        VStack {
            TextField("Type formula here", text: $form)
                .disableAutocorrection(true)
            Spacer()
            ForEach(eval(form), id: \.self) { item in
                HStack {
                    Text(String(item))
                    Spacer()
                }
            }
        }
        .padding()
    }
}


@main struct StackPuterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
