//
//  CustomeCorner.swift
//  Koi
//
//  Created by Edgar Mejía on 25/9/21.
//
#if !os(macOS)
import SwiftUI

struct CustomCorner: Shape {
    
    var corners: UIRectCorner
    
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
    
}
#endif
