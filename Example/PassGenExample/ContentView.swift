//
//  ContentView.swift
//  PassGenExample
//
//  Created by Xiao Jin on 2024/1/12.
//  Copyright © 2024 debugeek. All rights reserved.
//

import SwiftUI
import PassGen

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Length")
                Slider(value: .convert(from: $length), in: 10...100, step: 1)
                Text("\(length)")
            }

            HStack {
                Text("Password")
                TextField("", text: $result)
                Button("Generate", action: generate)
            }

            Divider()

            Toggle("Allows Lowercase Characters", isOn: $allowsLowercaseCharacters)
                .frame(maxWidth: .infinity, alignment: .leading)
            Toggle("Allows Uppercase Characters", isOn: $allowsUppercaseCharacters)
                .frame(maxWidth: .infinity, alignment: .leading)
            Toggle("Allows Digit Characters", isOn: $allowsDigitCharacters)
                .frame(maxWidth: .infinity, alignment: .leading)
            Toggle("Allows Punctuation Characters", isOn: $allowsPunctuationCharacters)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }

    @State private var length: Int = 32
    @State private var result: String = ""

    @State private var allowsLowercaseCharacters = true
    @State private var allowsUppercaseCharacters = true
    @State private var allowsDigitCharacters = true
    @State private var allowsPunctuationCharacters = false

    func generate() {
        var characters = [Character]()
        if allowsLowercaseCharacters {
            characters += ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j",
                           "k", "l", "m", "n", "o", "p", "q", "r", "s", "t",
                           "u", "v", "w", "x", "y", "z"]
        }
        if allowsUppercaseCharacters {
            characters += ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
                           "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
                           "U", "V", "W", "X", "Y", "Z"]
        }
        if allowsDigitCharacters {
            characters += ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
        }
        if allowsPunctuationCharacters {
            characters += ["`", "~", "!", "@", "#", "$", "%", "^", "&", "*",
                           "(", ")", "-", "_", "=", "+", "[", "{", "]", "}",
                           "\\", "|", ";", ":", "'", "\"", ",", "<", ".", ">",
                           "/", "?"]
        }
        if characters.count == 0 {
            return
        }

        result = PassGen(characters: characters, length: length)
            .shuffle()
            .generate()
    }
}

#Preview {
    ContentView()
}

public extension Binding {
    static func convert<TInt, TFloat>(from intBinding: Binding<TInt>) -> Binding<TFloat> where TInt: BinaryInteger, TFloat: BinaryFloatingPoint {
        return Binding<TFloat>(
            get: { TFloat(intBinding.wrappedValue) },
            set: { intBinding.wrappedValue = TInt($0) }
        )
    }
}
