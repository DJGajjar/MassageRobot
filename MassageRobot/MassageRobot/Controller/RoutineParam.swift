//
//  RoutineParam.swift
//  MassageRobot
//
//  Created by Rohit Parsana on 18/02/21.
//

import UIKit

class RoutineParam: UIView {

    
    class func instanceFromNib() -> RoutineParam {
        
        let view = UINib(nibName: "RoutineParam", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! RoutineParam
        return view
    }
    
    @IBOutlet weak var lblSegmentNo: UILabel!
    @IBOutlet weak var lblSegmentStart: UILabel!
    @IBOutlet weak var lblSegmentEnd: UILabel!
    @IBOutlet weak var viewLeftSpeed: UIView!
    @IBOutlet weak var viewRightSpeed: UIView!
    @IBOutlet weak var viewLeftForce: UIView!
    @IBOutlet weak var viewRightForce: UIView!
    @IBOutlet weak var lblLeftSpeed: UILabel!
    @IBOutlet weak var lblRightSpeed: UILabel!
    @IBOutlet weak var lblLeftForce: UILabel!
    @IBOutlet weak var lblRightForce: UILabel!
    @IBOutlet weak var txtTime: UnderlineTextField!
    
    var triLeftSpeed: TriangleView!
    var triRightSpeed: TriangleView!
    var triLeftForce: TriangleView!
    var triRightForce: TriangleView!
    
    var sliderValue = 0
    var delegate: SliderValueSetDelegate?
    var delegateRuler: RulerSizeDelegate?
    
    let picker = UIPickerView()
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        lblSegmentNo.text = String(format: "%02d", tag)
        
        triLeftSpeed = TriangleView(frame: CGRect(x: 0, y: 0, width: viewLeftSpeed.frame.width, height: 33))
        triLeftSpeed.backgroundColor = .white
        triLeftSpeed.setFillValue(value: 0)
        viewLeftSpeed.addSubview(triLeftSpeed)
        
        triRightSpeed = TriangleView(frame: CGRect(x: 0, y: 0, width: viewRightSpeed.frame.width, height: 33))
        triRightSpeed.backgroundColor = .white
        triRightSpeed.setFillValue(value: 0)
        viewRightSpeed.addSubview(triRightSpeed)
        
        triLeftForce = TriangleView(frame: CGRect(x: 0, y: 0, width: viewLeftForce.frame.width, height: 33))
        triLeftForce.backgroundColor = .white
        triLeftForce.setFillValue(value: 0)
        viewLeftForce.addSubview(triLeftForce)
        
        triRightForce = TriangleView(frame: CGRect(x: 0, y: 0, width: viewRightForce.frame.width, height: 33))
        triRightForce.backgroundColor = .white
        triRightForce.setFillValue(value: 0)
        viewRightForce.addSubview(triRightForce)
        
        picker.delegate = self
        picker.dataSource = self
        txtTime.delegate = self
        txtTime.inputView = picker
    }
    
    @IBAction func btnLeftSpeedAction(_ sender: UIButton) {
        sliderValue = 0
        delegate?.sliderValueSet(value: Float(triLeftSpeed.fillValue) * 100)
    }
    
    @IBAction func btnRightSpeedAction(_ sender: UIButton) {

        sliderValue = 1
        delegate?.sliderValueSet(value: Float(triRightSpeed.fillValue) * 100)
    }
    
    @IBAction func btnLeftForceAction(_ sender: UIButton) {
        sliderValue = 2
        delegate?.sliderValueSet(value: Float(triLeftForce.fillValue) * 100)
    }
    
    @IBAction func btnRightForceAction(_ sender: UIButton) {
        sliderValue = 3
        delegate?.sliderValueSet(value: Float(triRightForce.fillValue) * 100)
    }
    
}

extension RoutineParam: SliderValueSetDelegate
{
    func sliderValueSet(value: Float) {
        
        switch sliderValue {
        case 0:
            if triLeftSpeed != nil
            {
                triLeftSpeed.removeFromSuperview()
            }
            
            triLeftSpeed = TriangleView(frame: CGRect(x: 0, y: 0, width: viewLeftSpeed.frame.width, height: 33))
            triLeftSpeed.backgroundColor = .white
            triLeftSpeed.setFillValue(value: CGFloat(value / 100))
            viewLeftSpeed.addSubview(triLeftSpeed)
            
            lblLeftSpeed.text = "\(Int(value))%"
        case 1:
            if triRightSpeed != nil
            {
                triRightSpeed.removeFromSuperview()
            }
            
            triRightSpeed = TriangleView(frame: CGRect(x: 0, y: 0, width: viewRightSpeed.frame.width, height: 33))
            triRightSpeed.backgroundColor = .white
            triRightSpeed.setFillValue(value: CGFloat(value / 100))
            viewRightSpeed.addSubview(triRightSpeed)
            
            lblRightSpeed.text = "\(Int(value))%"
        case 2:
            if triLeftForce != nil
            {
                triLeftForce.removeFromSuperview()
            }
            
            triLeftForce = TriangleView(frame: CGRect(x: 0, y: 0, width: viewLeftForce.frame.width, height: 33))
            triLeftForce.backgroundColor = .white
            triLeftForce.setFillValue(value: CGFloat(value / 100))
            viewLeftForce.addSubview(triLeftForce)
            
            lblLeftForce.text = "\(Int(value))%"
        case 3:
            if triRightForce != nil
            {
                triRightForce.removeFromSuperview()
            }
            
            triRightForce = TriangleView(frame: CGRect(x: 0, y: 0, width: viewRightForce.frame.width, height: 33))
            triRightForce.backgroundColor = .white
            triRightForce.setFillValue(value: CGFloat(value / 100))
            viewRightForce.addSubview(triRightForce)
            
            lblRightForce.text = "\(Int(value))%"
        default:
            break
        }
    }
}


extension RoutineParam: UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtTime.text = "\(row + 1)"
        lblSegmentEnd.text = "\(row + 1)"
        delegateRuler?.rulerSize(size: row + 1, index: tag - 1)
    }
}

extension RoutineParam: UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        txtTime.text = "\(1)"
        lblSegmentEnd.text = "\(1)"
    }
}



//7 hours for all

