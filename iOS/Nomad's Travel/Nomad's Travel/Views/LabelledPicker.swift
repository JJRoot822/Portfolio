//
//  LabelledPicker.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 2/21/25.
//

import UIKit

class LabelledPicker: UIView {
    private var label = UILabel()
    private var field = UITextField()
    private var picker = UIPickerView()
    private var circleView = CircleView(color: .clear)
    private var pickerDelegate = TagColorPickerDelegate()

    var action: Selector!
    var target: Any?
    
    var labelText: String {
        set { label.text = newValue }
        get {
            guard let text = label.text else { return "" }
            return text
        }
    }
    
    var fieldText: String {
        guard let text = field.text else {
            return ""
        }
        
        return text
    }
    
    init(_ label: String, target: Any?, action: Selector) {
    super.init(frame: .zero)
    self.labelText = label
        self.target = target
        self.action = action
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not supported")
    }
    
    private func configure() {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .fillEqually
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(field)
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)

        let toolbar = UIToolbar()
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissPicker))
        
        toolbar.setItems([ spacer, doneButton ], animated: true)
        toolbar.sizeToFit()
        
        label.isAccessibilityElement = false
        
        field.accessibilityLabel = labelText
        field.leftView = circleView
        field.inputAccessoryView = toolbar
        field.inputView = picker
        field.addTarget(target, action: action, for: .valueChanged)
        
        picker.delegate = pickerDelegate
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func dismissPicker() {
        field.resignFirstResponder()
        field.text = Constants.colorNames[picker.selectedRow(inComponent: 0)]
    }
}
