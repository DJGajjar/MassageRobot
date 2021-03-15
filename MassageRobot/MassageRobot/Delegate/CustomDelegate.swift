//
//  CustomDelegate.swift
//  MassageRobot
//
//  Created by Rohit Parsana on 04/02/21.
//

import UIKit
import Foundation

protocol AllTouchDelegate {
    
    func touchFound()
}

protocol SliderValueSetDelegate {
    func sliderValueSet(value: Float)
}

protocol RulerSizeDelegate {
    func rulerSize(size: Int, index: Int)
}
