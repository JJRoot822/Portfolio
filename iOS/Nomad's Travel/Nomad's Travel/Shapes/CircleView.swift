//
//  CircleView.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 2/19/25.
//

import UIKit

class CircleView: UIView {
    var color: UIColor {
        didSet {
            setNeedsDisplay()
        }
    }
    
    init(color: UIColor) {
        self.color = color
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not Supported")
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setFillColor(color.cgColor)
        context.addEllipse(in: rect)
        context.drawPath(using: .fill)
    }

}
