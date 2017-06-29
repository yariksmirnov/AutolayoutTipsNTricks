//
//  StickyImageViewController.swift
//  AutolayoutTipsNTricks
//
//  Created by Yaroslav Smirnov on 07/04/16.
//  Copyright © 2016 Yaroslav Smirnov. All rights reserved.
//

import UIKit
import PureLayout
import LoremIpsum

class StickyImageViewController: UIViewController {
    
    var scrollView = UIScrollView()
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
         return .lightContent
    }
    
    override func viewDidLoad() {
        automaticallyAdjustsScrollViewInsets = false
        
        view.addSubview(scrollView)
        view.backgroundColor = UIColor.white
        
        scrollView.autoPinEdgesToSuperviewEdges()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        
        let imageView = UIImageView(image: UIImage(named: "180ec864a554a1ebdc8cd21979b5a4c8.1000x1000x1"))
        imageView.contentMode = .scaleAspectFill
        scrollView.addSubview(imageView)
        
        imageView.autoMatch(.width, to: .width, of: scrollView)
        imageView.autoPinEdge(toSuperviewEdge: .left)
        imageView.autoPinEdge(toSuperviewEdge: .right)
        
        imageView.autoPinEdge(.top,
                              to: .top,
                              of: view,
                              withOffset: 0)
        
        let dummyView = UIView()
        scrollView.addSubview(dummyView)
        dummyView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero,
                                                         excludingEdge: .bottom)
        dummyView.autoMatch(.width, to: .width, of: scrollView)
        dummyView.autoMatch(.height, to: .width, of: dummyView)
        dummyView.isHidden = true
        
        let textView = UITextView()
        scrollView.addSubview(textView)
        textView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: .top)
        textView.autoPinEdge(.top, to: .bottom, of: imageView)
        textView.autoPinEdge(.top, to: .bottom, of: dummyView)
        textView.text = NSLocalizedString("nevermind", comment: "")
        
        textView.layoutIfNeeded()
        
        let textBounds = textView.layoutManager.usedRect(for: textView.textContainer)
        textView.autoSetDimension(.height,
                                  toSize: textBounds.size.height +
                                    textView.textContainerInset.top +
                                    textView.textContainerInset.bottom)
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
}
