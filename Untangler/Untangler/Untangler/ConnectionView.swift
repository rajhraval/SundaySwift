//
//  ConnectionView.swift
//  Untangler
//
//  Created by RAJ RAVAL on 01/09/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import UIKit

class ConnectionView: UIView {

    var dragChanged: (() -> Void)?
    var dragFinished: (() -> Void)?
    var touchStartPos = CGPoint.zero
    weak var after: ConnectionView!
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        touchStartPos = touch.location(in: self)
        
        touchStartPos.x -= frame.size.width / 2
        touchStartPos.y -= frame.size.height / 2
        
        transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
        superview?.bringSubviewToFront(self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let point = touch.location(in: superview)
        
        center = CGPoint(x: point.x - touchStartPos.x, y: point.y - touchStartPos.y)
        dragChanged?()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        transform = .identity
        dragFinished?()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }
    
}
