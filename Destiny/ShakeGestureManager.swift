//
//  ShakeGestureManager.swift
//  Destiny
//
//  Created by Stephan Tromer on 03/09/2020.
//  Copyright © 2020 Stephan Tromer. All rights reserved.
//

import SwiftUI
import Combine

let messagePublisher = PassthroughSubject<Void, Never>()

class ShakableViewController: UIViewController {

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        messagePublisher.send()
    }
}

struct ShakableViewRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> ShakableViewController {
        ShakableViewController()
    }
    
    func updateUIViewController(_ uiViewController: ShakableViewController, context: Context) {
        
    }
}
