//
//  SettingsViewController.swift
//  MassageRobot
//
//  Created by Rohit Parsana on 18/02/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var viewSliderPopup: UIView!
    @IBOutlet weak var lblSliderValue: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var constContainerWidth: NSLayoutConstraint!
    @IBOutlet weak var svContainer: UIScrollView!
    @IBOutlet weak var viewRuler: UIView!
    
    var triLeftSpeed: TriangleView!
    var triRightSpeed: TriangleView!
    var triLeftForce: TriangleView!
    var triRightForce: TriangleView!
    
    var sliderValue = 0
    var numberOfRoutine = 0
    var delegate: SliderValueSetDelegate?
    var arrRoutines = [RoutineParam]()
    var arrRuler = [UIView]()
    
    let picker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewRoutine = RoutineParam.instanceFromNib()
        viewRoutine.delegate = self
        viewRoutine.delegateRuler = self
        delegate = viewRoutine
        svContainer.addSubview(viewRoutine)
        svContainer.contentSize = CGSize(width: screenWidth * 1, height: viewRoutine.frame.height)
        numberOfRoutine += 1
        arrRoutines.append(viewRoutine)
        viewRoutine.tag = arrRoutines.count
        
        let view = UIView(frame: CGRect(x: 12, y: 32, width: 28, height: 37))
        view.backgroundColor = .red
        viewRuler.addSubview(view)
        arrRuler.append(view)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        constContainerWidth.constant = CGFloat(numberOfRoutine) * screenWidth
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {

        sender.value = roundf(sender.value)

        let trackRect = sender.trackRect(forBounds: sender.frame)
        let thumbRect = sender.thumbRect(forBounds: sender.bounds, trackRect: trackRect, value: sender.value)
        lblSliderValue.center = CGPoint(x: thumbRect.midX, y: lblSliderValue.center.y)

        lblSliderValue.text = "\(Int(sender.value))"
    }
    
    @IBAction func btnPopupClose(_ sender: UIButton) {
        
        viewSliderPopup.isHidden = true
        delegate?.sliderValueSet(value: slider.value)
    }
    
    @IBAction func btnMinusAction(_ sender: UIButton) {
        
        if arrRoutines.count != 1
        {
            numberOfRoutine -= 1
            let viewRoutine = arrRoutines.removeLast()
            viewRoutine.removeFromSuperview()
            svContainer.contentSize = CGSize(width: screenWidth * CGFloat(numberOfRoutine), height: viewRoutine.frame.height)
        }
    }
    
    @IBAction func btnPlusAction(_ sender: UIButton) {
        let viewRoutine = RoutineParam.instanceFromNib()
        
        viewRoutine.delegate = self
        delegate = viewRoutine
        viewRoutine.delegateRuler = self
        viewRoutine.frame = CGRect(x: screenWidth * CGFloat(numberOfRoutine), y: 0, width: screenWidth, height: viewRoutine.frame.height)

        numberOfRoutine += 1
        svContainer.addSubview(viewRoutine)
        svContainer.contentSize = CGSize(width: screenWidth * CGFloat(numberOfRoutine), height: viewRoutine.frame.height)
        arrRoutines.append(viewRoutine)
        viewRoutine.tag = arrRoutines.count
        
        let view = UIView(frame: CGRect(x: 12 + (arrRuler.last?.frame.width ?? 0), y: 32, width: 28, height: 37))
        view.backgroundColor = [.red, .green, .blue, .orange][arrRoutines.count % 4]
        viewRuler.addSubview(view)
        arrRuler.append(view)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SettingsViewController: SliderValueSetDelegate
{
    func sliderValueSet(value: Float) {
        viewSliderPopup.isHidden = false
        slider.value = Float(value)
        
        let trackRect = slider.trackRect(forBounds: slider.frame)
        let thumbRect = slider.thumbRect(forBounds: slider.bounds, trackRect: trackRect, value: slider.value)
        lblSliderValue.center = CGPoint(x: thumbRect.midX, y: lblSliderValue.center.y)
        lblSliderValue.text = "\(Int(slider.value))"
    }
}

extension SettingsViewController: RulerSizeDelegate
{
    func rulerSize(size: Int, index: Int) {
        let view = arrRuler[index]
        view.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: CGFloat(28 * size), height: view.frame.height)
        arrRuler[index] = view
    }
}
