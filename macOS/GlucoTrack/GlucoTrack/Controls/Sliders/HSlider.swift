//
//  HSlider.swift
//  GlucoTrack
//
//  Created by Joshua Root on 9/20/24.
//

import SwiftUI

extension HSlider {
    func tickMarks(number: Int, stepByTicks: Bool, position: NSSlider.TickMarkPosition) -> HSlider {
        var slider = self
        slider.numberOfTickMarks = number
        slider.allowsTickMarkValuesOnly = stepByTicks
        slider.tickMarkPosition = position
        
        return slider
    }
    
    func trackColor(_ color: NSColor) -> HSlider {
        var slider = self
        slider.trackColor = color
    
        return slider
    }
}

extension HSlider {
    class Coordinator: NSResponder {
        var parent: HSlider
        
        init(_ parent: HSlider) {
            self.parent = parent
            
            super.init()
        }
        
        required init(coder: NSCoder) {
            fatalError("Not supported.")
        }
        
        @objc fileprivate func valueChanged(_ slider: NSSlider) {
            parent.value = slider.doubleValue
        }
    }
}

struct HSlider: NSViewRepresentable {
    @Binding var value: Double
    
    var label: String
    var min: Double = 0
    var max: Double = 1
    var altStep: Double?

    var trackColor: NSColor?
    var numberOfTickMarks: Int = 0
    var allowsTickMarkValuesOnly: Bool = false
    var tickMarkPosition: NSSlider.TickMarkPosition = .leading
    
    init(value: Binding<Double>, label: String, min: Double = 0, max: Double = 1, altStep: Double? = nil) {
        self._value = value
        self.label = label
        self.min = min
        self.max = max
        self.altStep = altStep
    }
    
    
    func makeNSView(context: Context) -> NSSlider {
        var slider = NSSlider()
        slider.target = context.coordinator
        slider.action = #selector(context.coordinator.valueChanged)
        slider.sliderType = .linear
        slider.isVertical = false
        slider.setAccessibilityLabel(label)
        slider.doubleValue = value
        slider.minValue = min
        slider.maxValue = max
        slider.allowsTickMarkValuesOnly = allowsTickMarkValuesOnly
        slider.numberOfTickMarks = numberOfTickMarks
        slider.trackFillColor = trackColor
        
        if let altStep = altStep {
            slider.altIncrementValue = altStep
        }
        
        return slider
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func updateNSView(_ nsView: NSSlider, context: Context) {
        nsView.doubleValue = value
        nsView.trackFillColor = trackColor
        nsView.allowsTickMarkValuesOnly = allowsTickMarkValuesOnly
        nsView.numberOfTickMarks = numberOfTickMarks
        nsView.tickMarkPosition = tickMarkPosition
    }
    
    
}
