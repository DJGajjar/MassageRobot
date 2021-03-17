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
    @IBOutlet weak var txtLeftTool: UnderlineTextField!
    @IBOutlet weak var txtRightTool: UnderlineTextField!
    @IBOutlet weak var txtLeftPath: UnderlineTextField!
    @IBOutlet weak var txtRightPath: UnderlineTextField!
    @IBOutlet weak var txtLeftLocation: UnderlineTextField!
    @IBOutlet weak var txtRightLocation: UnderlineTextField!
    
    @IBOutlet weak var btnLocationLfrt: UIButton!
    
    var triLeftSpeed: TriangleView!
    var triRightSpeed: TriangleView!
    var triLeftForce: TriangleView!
    var triRightForce: TriangleView!
    
    var sliderValue = 0
    var delegate: SliderValueSetDelegate?
    var delegateRuler: RulerSizeDelegate?
    var delegateLocation: LocationDelegate?
    
    let picker = UIPickerView()
    
    let arrLRLocation = ["none", "Linear", "Circular", "Random", "Point"]
    let arrLRTool = ["none", "Omni", "Inline", "Point", "Kneading","Sport","Precussion","Calibration"]
    
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
        txtLeftTool.delegate = self
        txtRightTool.delegate = self
        txtLeftPath.delegate = self
        txtRightPath.delegate = self
        txtLeftLocation.delegate = self
        txtRightLocation.delegate = self
        
        txtTime.inputView = picker
        txtLeftTool.inputView = picker
        txtRightTool.inputView = picker
        txtLeftPath.inputView = picker
        txtRightPath.inputView = picker
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
    
    @IBAction func btnLeftLocationAction(_ sender: UIButton) {
        delegateLocation?.locationViewAnimation()
    }
    
    @IBAction func btnRightLocationAction(_ sender: UIButton) {
        delegateLocation?.locationViewAnimation()
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
        
        if txtTime.isEditing {
            return 60
        }else if txtLeftTool.isEditing {
            return arrLRTool.count
        }else if txtRightTool.isEditing {
            return arrLRTool.count
        }else if txtLeftPath.isEditing {
            return arrLRLocation.count
        }else if txtRightPath.isEditing {
            return arrLRLocation.count
        }else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if txtTime.isEditing {
            return "\(row + 1)"
        }else if txtLeftTool.isEditing {
            return arrLRTool[row]
        }else if txtRightTool.isEditing {
            return arrLRTool[row]
        }else if txtLeftPath.isEditing {
            return arrLRLocation[row]
        }else if txtRightPath.isEditing {
            return arrLRLocation[row]
        }else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if txtTime.isEditing {
            txtTime.text = "\(row + 1)"
            lblSegmentEnd.text = "\(row + 1)"
            delegateRuler?.rulerSize(size: row + 1, index: tag - 1)
        }else if txtLeftTool.isEditing {
            txtLeftTool.text = arrLRTool[row]
            txtLeftTool.tag = row
        }else if txtRightTool.isEditing {
            txtRightTool.text = arrLRTool[row]
            txtRightTool.tag = row
        }else if txtLeftPath.isEditing {
            txtLeftPath.text = arrLRLocation[row]
            txtLeftPath.tag = row
        }else if txtRightPath.isEditing {
            txtRightPath.text = arrLRLocation[row]
            txtRightPath.tag = row
        }
    }
}

extension RoutineParam: UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if txtTime.isEditing {
            txtTime.text = "\(1)"
            lblSegmentEnd.text = "\(1)"
        }else if txtLeftTool.isEditing {
            txtLeftTool.text = arrLRTool[textField.tag]
            picker.selectRow(txtLeftTool.tag, inComponent: 0, animated: true)
        }else if txtRightTool.isEditing {
            txtRightTool.text = arrLRTool[textField.tag]
            picker.selectRow(txtRightTool.tag, inComponent: 0, animated: true)
        }else if txtLeftPath.isEditing {
            txtLeftPath.text = arrLRLocation[textField.tag]
            picker.selectRow(txtLeftPath.tag, inComponent: 0, animated: true)
        }else if txtRightPath.isEditing {
            txtRightPath.text = arrLRLocation[textField.tag]
            picker.selectRow(txtRightPath.tag, inComponent: 0, animated: true)
        }else if txtLeftLocation.isEditing {
            delegateLocation?.locationViewAnimation()
        }else if txtRightLocation.isEditing {
            delegateLocation?.locationViewAnimation()
        }
        
        if textField == txtLeftTool || textField == txtRightTool || textField == txtLeftLocation || textField == txtRightLocation || textField == txtLeftPath || textField == txtRightPath {
            picker.reloadAllComponents()
        }
    }
}



//7 hours for all

