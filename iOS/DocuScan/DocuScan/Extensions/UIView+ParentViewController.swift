//
//  UIView+ParentViewController.swift
//  DocuScan
//
//  Created by Joshua Root on 5/17/25.
//

import UIKit

extension UIView {
	var parentViewController: UIViewController? {
		var responder: UIResponder? = self.next
		while responder != nil {
			if let viewController = responder as? UIViewController {
				return viewController
			}
			responder = responder?.next
		}
		return nil
	}
}

