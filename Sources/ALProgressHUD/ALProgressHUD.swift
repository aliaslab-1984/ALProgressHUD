//
//  ALProgressHUD.swift
//
//  Created by Enrico Bonaldo on 12/01/18.
//  Copyright © 2018 Enrico Bonaldo. All rights reserved.
//
// This software is provided 'as-is', without any express or implied warranty.
//
//  In no event will the authors be held liable for any damages arising from the use of this software.
//

import UIKit

/**
 Progress HUD (Head Up Display)
 */
public class ALProgressHUD: ALVisualEffectView {
    
    private let activityIndicator: UIActivityIndicatorView
    
    private var hidingView: UIView?
    
    private var largeIndicator = false
    
    public var isVisible: Bool {
        return activityIndicator.isAnimating
    }
    
    public required init(text: String = "", shadowing: Bool = false) {
        
        activityIndicator = UIActivityIndicatorView(style: shadowing ? .white : .gray)
        super.init(text: text, shadowing: shadowing)
    }
    
    public required init(withLargeIndicator text: String = "") {
        
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        super.init(text: text, shadowing: true)
        
        largeIndicator = true
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /** Hide the app
     
    Call this instead of `view.addSubview(progressHUD)` to cover the app;
    `progressHUD.removeFromSuperview()` close progressHUD in both cases
     
    - Parameter view: the actual UIViewController's view
    */
    public func overApp(view: UIView) {
        
        let hidingView = UIView()
        hidingView.frame = view.bounds
        hidingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hidingView.backgroundColor = UIColor.init(white: 1.0, alpha: 0.6)
        self.hidingView = hidingView
        view.addSubview(hidingView)
        view.addSubview(self)
    }
    
    public override func setup() {
        contentView.addSubview(activityIndicator)
        contentView.addSubview(label)
    }
    
    public override func didMoveToSuperview() {
        
        super.didMoveToSuperview()
        
        if self.superview != nil {
            
            // HUD shown
            label.text = text
            label.textAlignment = NSTextAlignment.center
            label.textColor = textColor
            
            layer.cornerRadius = 8.0
            layer.masksToBounds = true
            
            setNeedsLayout()
            activityIndicator.startAnimating()
        } else {
            
            // HUD hidden
            activityIndicator.stopAnimating()
            
            hidingView?.removeFromSuperview()
            hidingView = nil
        }
    }
    
    public override func layoutSubviews() {
        
        guard let superview = self.superview else {
            return
        }
        guard isVisible else {
            return
        }
        
        let isPhone = UIDevice.current.userInterfaceIdiom == .phone
        let sideFactor: CGFloat = isPhone ? 1.2 : 1.8
        let font = isPhone ? UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 20)
        
        let frameWidth = superview.frame.width / sideFactor
        let fontAttributes = [NSAttributedString.Key.font: font]
        let textSize = text.size(withAttributes: fontAttributes)
        
        if largeIndicator {
            largeIndicatoFrames(with: textSize, in: superview.frame, using: frameWidth)
        } else {
            smallIndicatorFrames(with: textSize, in: superview.frame, using: frameWidth)
        }
        label.font = font
    }
    
    private func smallIndicatorFrames(with textSize: CGSize,
                                      in superviewFrame: CGRect,
                                      using frameWidth: CGFloat) {
        
        let horizontalPadding: CGFloat = 5
        
        let activityIndicatorSize: CGFloat = 40.0
        
        let totalHorizontalPadding: CGFloat = horizontalPadding * (text.isEmpty ? 2 : 3)
        let width = min(frameWidth, textSize.width + activityIndicatorSize + totalHorizontalPadding)
        let height: CGFloat = 50.0
        
        self.frame = CGRect(x: (superviewFrame.width - width) / 2,
                            y: (superviewFrame.height - height) / 2,
                            width: width,
                            height: height)
        
        activityIndicator.frame = CGRect(x: horizontalPadding,
                                         y: (height - activityIndicatorSize) / 2,
                                         width: activityIndicatorSize,
                                         height: activityIndicatorSize)
        
        label.frame = CGRect(x: activityIndicatorSize + horizontalPadding,
                             y: 0,
                             width: width - activityIndicatorSize - totalHorizontalPadding,
                             height: height)
    }
    
    private func largeIndicatoFrames(with textSize: CGSize,
                                     in superviewFrame: CGRect,
                                     using frameWidth: CGFloat) {
        
        let horizontalPadding: CGFloat = 5
        let verticalPadding: CGFloat = 7
        
        let activityIndicatorSize: CGFloat = 60.0
        
        let totalHorizontalPadding: CGFloat = horizontalPadding * 2
        let totalVerticalPadding: CGFloat = verticalPadding * (text.isEmpty ? 2 : 3)
        let textWidth = textSize.width
        let textHeight = text.isEmpty ? 0.0 : textSize.height
        
        let width = min(frameWidth, max(textWidth, activityIndicatorSize) + totalHorizontalPadding)
        let height: CGFloat = activityIndicatorSize + textHeight + totalVerticalPadding
        
        self.frame = CGRect(x: (superviewFrame.width - width) / 2,
                            y: (superviewFrame.height - height) / 2,
                            width: width,
                            height: height)
        
        activityIndicator.frame = CGRect(x: (width - activityIndicatorSize) / 2,
                                         y: verticalPadding,
                                         width: activityIndicatorSize,
                                         height: activityIndicatorSize)
        
        label.frame = CGRect(x: horizontalPadding,
                             y: verticalPadding * 2 + activityIndicatorSize,
                             width: width - totalHorizontalPadding,
                             height: textHeight)
    }
}
