//
//  UIView+Constraints.swift
//  DocuScan
//
//  Created by Joshua Root on 4/11/25.
//

import UIKit

extension UIView {
	func pinToCenter( of view: UIView, useSafeAreaLayoutGuide: Bool) {
		if useSafeAreaLayoutGuide {
			NSLayoutConstraint.activate([
				centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
				centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
			])
		} else {
			NSLayoutConstraint.activate([
				centerXAnchor.constraint(equalTo: view.centerXAnchor),
				centerYAnchor.constraint(equalTo: view.centerYAnchor)
			])
		}
	}
	
	func pinToBottomLeading(of view: UIView, leadingPadding: CGFloat, bottomPadding: CGFloat, useSafeAreaLayoutGuide: Bool) {
		if useSafeAreaLayoutGuide {
			NSLayoutConstraint.activate([
				leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: leadingPadding),
				bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: bottomPadding)
			])
		} else {
			NSLayoutConstraint.activate([
				leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingPadding),
				bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomPadding)
			])
		}
	}
	
	func pinToBottomTrailing(of view: UIView, trailingPadding: CGFloat, bottomPadding: CGFloat, useSafeAreaLayoutGuide: Bool) {
		if useSafeAreaLayoutGuide {
			NSLayoutConstraint.activate([
				trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: trailingPadding),
				bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: bottomPadding)
			])
		} else {
			NSLayoutConstraint.activate([
				trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailingPadding),
				bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomPadding)
			])
		}
	}
	
	func pinTrailingToCenterX(of view: UIView, padding: CGFloat, useSafeAreaLayoutGuide: Bool) {
		if useSafeAreaLayoutGuide {
			NSLayoutConstraint.activate([
				trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: padding)
			])
		} else {
			NSLayoutConstraint.activate([
				trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: padding)
			])
		}
	}
	
	func pinLeadingToCenterX(of view: UIView, padding: CGFloat, useSafeAreaLayoutGuide: Bool) {
		if useSafeAreaLayoutGuide {
			NSLayoutConstraint.activate([
				leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: padding)
			])
		} else {
			NSLayoutConstraint.activate([
				leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: padding)
			])
		}
	}

	func pinSize(width: CGFloat, height: CGFloat) {
		NSLayoutConstraint.activate([
			widthAnchor.constraint(equalToConstant: width),
			heightAnchor.constraint(equalToConstant: height)
		])
	}
	
	func pinHeight(height: CGFloat) {
		NSLayoutConstraint.activate([
			heightAnchor.constraint(equalToConstant: height)
		])
	}
	
	func pinWidth(width: CGFloat) {
		NSLayoutConstraint.activate([
			widthAnchor.constraint(equalToConstant: width)
		])
	}
}
