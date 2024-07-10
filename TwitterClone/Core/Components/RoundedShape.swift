//
//  RoundedShape.swift
//  TwitterClone
//
//  Created by Ozgun Efe on 04/07/2024.
//

import SwiftUI

// This code just a custom modofier. Herhangi bir seklin kenarlarina kivrim vermek icin kullaniliyor.
struct RoundedShape: Shape {
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 80, height: 80))
        
        return Path(path.cgPath)
    }
}
