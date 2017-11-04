//
//  CustomSegmentedController.swift
//  CustomSeg
//
//  Created by Mackenzie Boudreau on 2016-01-25.
//  Copyright © 2016 Mackenzie Boudreau. All rights reserved.
//

import UIKit

@IBDesignable class CustomSegmentedController: UIControl {
    
    private var labels = [UILabel]()
    
    var items = [String]() {
        didSet {
            setupLabels()
        }
    }
    
    private var selectedView: UIView?
    
    @IBInspectable var selectionViewColor: UIColor = UIColor(white: 0.1, alpha: 1){
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var selectedTextColor: UIColor = UIColor(white: 0.10, alpha: 1){
        didSet {
            setupLabels()
        }
    }
    
    @IBInspectable var unselectedTextColor: UIColor = UIColor(white: 0.6, alpha: 1){
        didSet {
            setupLabels()
        }
    }
    
    @IBInspectable var background: UIColor = UIColor(white: 0.97, alpha: 1){
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var border: UIColor = UIColor(white: 0.9, alpha: 1){
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var borderWidth: Int = 1 {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var fontSize: Int = 15{
        didSet {
            setupLabels()
        }
    }
    
    private var seperatorView: UIView?
    
    @IBInspectable var selectedIndex: Int = 0 {
        didSet {
            if selectedIndex < labels.count {
                didSelectNewIndex()
            }
        }
    }
    
    private func setupLabels() {
        for label in labels {
            label.removeFromSuperview()
            labels.removeAll(keepingCapacity: true)
        }
        if items.count > 0 {
            for index in 0...items.count - 1 {
                let newLabel = UILabel(frame: CGRect.zero)
                newLabel.text = items[index]
                newLabel.textColor = index == selectedIndex ? selectedTextColor : unselectedTextColor
                newLabel.textAlignment = .center
                newLabel.font = UIFont(name: "Avenir-Black", size: CGFloat(fontSize))
                
                
                self.addSubview(newLabel)
                labels.append(newLabel)
            }
        }
    }
    
    private func setupView() {
        backgroundColor = background
        layer.borderColor = border.cgColor
        layer.borderWidth = CGFloat(borderWidth)
        setupLabels()
        
        selectedView = UIView(frame: CGRect.zero)
        selectedView?.backgroundColor = selectionViewColor
        insertSubview(selectedView!, at: 0)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSubviews() {
        let labelWidth = self.bounds.width / CGFloat(items.count)
        let labelHeight = self.bounds.height
        
        if items.count > 0 {
            for index in 0...items.count - 1 {
                let label = labels[index]
                let xpos = CGFloat(index) * labelWidth
                label.frame = CGRect(x: xpos, y: 0, width: labelWidth, height: labelHeight)
                
                if index == selectedIndex {
                    selectedView?.frame = label.frame
                    selectedView?.frame.size.height = 4
                    selectedView?.frame.origin.y = label.frame.height - 4
                }
                
                if index != 0 {
                    let seperatorHeight = bounds.height - (bounds.height / 2)
                    let seperatorWidth = 1
                    seperatorView = UIView(frame: CGRect(x: xpos, y: CGFloat(bounds.height / 4), width: CGFloat(seperatorWidth), height: CGFloat(seperatorHeight)))
                    seperatorView?.backgroundColor = UIColor(white: 0.9, alpha: 1)
                    addSubview(seperatorView!)
                }
            }
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        var calculatedIndex: Int?
        
        for (index, label) in labels.enumerated() {
            if label.frame.contains(location) {
                calculatedIndex = index
            }
        }
        
        if calculatedIndex != nil {
            selectedIndex = calculatedIndex!
            sendActions(for: .valueChanged)
        }
        return false
    }
    
    

    private func didSelectNewIndex() {
        for label in labels {
            label.textColor = unselectedTextColor
        }
        let selectedLabel = labels[selectedIndex]
        selectedLabel.textColor = selectedTextColor
        
        UIView.animate(withDuration: 0.2, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 4, options: .curveEaseInOut, animations: { () -> Void in
            self.selectedView?.frame = selectedLabel.frame
            self.selectedView?.frame.size.height = 4
            self.selectedView?.frame.origin.y = selectedLabel.frame.height - 4
            }, completion: nil)
    
    }
    
}
