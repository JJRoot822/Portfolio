//
//  LabelledField.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 2/21/25.
//

import UIKit

class LabelledField: UIView {
    private var label = UILabel()
    private var field = UITextField()
    
    var labelText: String {
        set { label.text = newValue }
        get {
            guard let text = label.text else { return "" }
            return text
        }
    }
    
    var fieldText: String {
        set { field.text = newValue }
        get {
            guard let text = field.text else { return "" }
            return text
        }
    }
    
    init(_ label: String) {
    super.init(frame: .zero)
    self.labelText = label
        
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
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        
        toolbar.setItems([ spacer, doneButton ], animated: true)
        toolbar.sizeToFit()
        
        label.isAccessibilityElement = false
        field.accessibilityLabel = labelText
        
        field.inputAccessoryView = toolbar
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func dismissKeyboard() {
        field.resignFirstResponder()
    }
}
