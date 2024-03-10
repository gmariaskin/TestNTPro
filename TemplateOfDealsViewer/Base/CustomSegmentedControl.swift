//
//  CustomSegmentedControl.swift
//  TemplateOfDealsViewer
//
//  Created by Gleb on 08.03.2024.
//

import UIKit

class CustomSegmentedControl: UISegmentedControl {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let currentIndex = selectedSegmentIndex
        super.touchesBegan(touches, with: event)
        
        if currentIndex == selectedSegmentIndex {
            sendActions(for: .touchDown)
        }
    }
}
