//
//  CustomInputField.swift
//  TwitterClone
//
//  Created by Ozgun Efe on 04/07/2024.
//

import SwiftUI

struct CustomInputField: View {
    let imageName: String
    let placeHolderText: String
    var isSecureField: Bool? = false
    @Binding var text: String
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.darkGray))
                    .padding(.trailing, 6)
                
                // Burada optinal bir isSecureField alani olusturdum boylece her seferinde kullandigimiz her yerde false olarak yazmamiz gerekmeyecek. Sadece password bolumlerinde isSecureField = true olarak verdigimizde input alani secureField olacak. Default degerini false verdim cunku diger input alanlarinin secureField olmasini istemiyorum.
                if isSecureField ?? false {
                    SecureField(placeHolderText, text: $text)
                } else {
                    TextField(placeHolderText, text: $text)
                }
            }
            
            Divider()
                .background(Color(.darkGray))
        }
    }
}

#Preview {
    CustomInputField(imageName: "envelope", 
                     placeHolderText: "Email",
                     isSecureField: false,
                     text: .constant(""))
}
