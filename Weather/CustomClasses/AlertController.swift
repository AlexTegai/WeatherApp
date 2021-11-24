//
//  AlertController.swift
//  Weather
//
//  Created by Alex Tegai on 20.10.2021.
//

import UIKit

class AlertController: UIAlertController {
    func action(completion: @escaping (String) -> Void) {
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard
                let newText = self.textFields?.first?.text,
                !newText.isEmpty
            else { return }
            completion(newText)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        addAction(saveAction)
        addAction(cancelAction)
        addTextField { textField in
            textField.placeholder = "City"
        }
    }
    
    func okAction() {
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        addAction(okAction)
    }
}
