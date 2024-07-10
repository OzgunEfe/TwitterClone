//
//  TextArea.swift
//  TwitterClone
//
//  Created by Ozgun Efe on 04/07/2024.
//

import SwiftUI

struct TextArea: View {
    @Binding var text: String
    let placeholder: String
    
    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }
    
    
    var body: some View {
        ZStack(alignment: .topLeading){
            
            TextEditor(text: $text)
                .background(Color.clear)
                .padding(4)
            
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(.placeholderText))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 12)
            }

        }
        .font(.body)
    }
}

