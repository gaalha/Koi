//
//  RefreshableScrollView.swift
//  Koi
//
//  Created by Edgar Mejía on 25/9/21.
//
#if !os(macOS)
import SwiftUI
import UIKit

struct RefreshableScrollView<Content: View>: UIViewRepresentable {
    
    var content: Content
    
    var onRefresh: (UIRefreshControl) -> ()
    
    var refreshControl = UIRefreshControl()
    
    init(@ViewBuilder content: @escaping ()-> Content, onRefresh: @escaping (UIRefreshControl) -> ()) {
        self.content = content()
        self.onRefresh = onRefresh
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let uiScrollView = UIScrollView()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.tintColor = .red
        refreshControl.addTarget(context.coordinator, action: #selector(context.coordinator.onRefresh), for: .valueChanged)
        
        setUpView(uiScrollView: uiScrollView)
        uiScrollView.refreshControl = refreshControl
        
        return uiScrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        setUpView(uiScrollView: uiView)
    }
    
    func setUpView(uiScrollView: UIScrollView) {
        let hostView = UIHostingController(rootView: content.frame(maxHeight: .infinity, alignment: .top))
        hostView.view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            hostView.view.topAnchor.constraint(equalTo: uiScrollView.topAnchor),
            hostView.view.bottomAnchor.constraint(equalTo: uiScrollView.bottomAnchor),
            hostView.view.leadingAnchor.constraint(equalTo: uiScrollView.leadingAnchor),
            hostView.view.trailingAnchor.constraint(equalTo: uiScrollView.trailingAnchor),
            
            hostView.view.widthAnchor.constraint(equalTo: uiScrollView.widthAnchor),
            hostView.view.heightAnchor.constraint(greaterThanOrEqualTo: uiScrollView.heightAnchor, constant: 1)
        ]
        

        uiScrollView.subviews.last?.removeFromSuperview()
        uiScrollView.addSubview(hostView.view)
        uiScrollView.addConstraints(constraints)
    }
    
    class Coordinator: NSObject {
        
        var parent: RefreshableScrollView
        
        init(parent: RefreshableScrollView) {
            self.parent = parent
        }
        
        @objc func onRefresh() {
            parent.onRefresh(parent.refreshControl)
        }
        
    }
    
}
#endif
