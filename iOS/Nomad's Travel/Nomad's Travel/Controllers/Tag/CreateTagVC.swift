//
//  CreateTagVC.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 2/19/25.
//

import UIKit

class CreateTagVC: UIViewController {
    let dataController = DataController()

    var delegate: CreateTagDelegate?
    
    var tagTitleField: LabelledField!
    var tagColorPicker: LabelledPicker!
    var addTagButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [ .large() ]
            presentationController.prefersEdgeAttachedInCompactHeight = true
            presentationController.prefersGrabberVisible = true
        }
        
        tagTitleField = LabelledField("Tag Title")
        tagColorPicker = LabelledPicker("Tag Color", target: self, action: #selector(colorChanged))
        
        tagTitleField.translatesAutoresizingMaskIntoConstraints = false
        tagColorPicker.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tagTitleField)
        view.addSubview(tagColorPicker)
    
        var addButtonConfiguration: UIButton.Configuration = .borderedProminent()
        addButtonConfiguration.image = UIImage(systemName: "plus")
        addButtonConfiguration.title = "Add Tag"
        addButtonConfiguration.baseBackgroundColor = .systemBlue
        addButtonConfiguration.baseForegroundColor = .white
        addButtonConfiguration.cornerStyle = .dynamic
        addButtonConfiguration.titleAlignment = .center
        
        addTagButton = UIButton()
        addTagButton.configuration = addButtonConfiguration
        addTagButton.addTarget(self, action: #selector(addTagTapped), for: .touchUpInside)
        addTagButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addTagButton)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            tagTitleField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tagTitleField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tagTitleField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            tagColorPicker.topAnchor.constraint(equalTo: tagTitleField.bottomAnchor, constant: 20),
            tagColorPicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tagColorPicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            addTagButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addTagButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            addTagButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func colorChanged(_ sender: UITextField) {
        guard let text = sender.text,
              let leftView = sender.leftView as? CircleView else { return }
        leftView.color = TagColor.uiColor(for: TagColor.color(forColorName: text))
    }
    
    @objc private func addTagTapped() {
        guard !tagTitleField.fieldText.isEmpty,
              !tagColorPicker.fieldText.isEmpty else { return }
        
        do {
            try dataController.createTag(
                title: tagTitleField.fieldText,
                color: TagColor.colorAssetName(for: tagColorPicker.fieldText)
            )
            
            delegate?.didFinishCreatingTag()
            
            dismiss(animated: true)
        } catch {
            let alert = UIAlertController(
                title: "Failed to Create a Tag",
                message: "Something went wrong when trying to create a new tag. Please try again later",
                preferredStyle: .alert
            )
            alert.addAction(.init(title: "Ok", style: .default))
            
            present(alert, animated: true)
        }
    }
}
