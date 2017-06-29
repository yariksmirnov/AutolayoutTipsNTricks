//
//  OnboardingViewController.swift
//  AutolayoutTipsNTricks
//
//  Created by Yaroslav Smirnov on 07/04/16.
//  Copyright © 2016 Yaroslav Smirnov. All rights reserved.
//

import UIKit
import PureLayout

class OnboardingViewController: UIViewController, UIScrollViewDelegate {
    
    var scrollView = UIScrollView()
    var pagesControl = UIPageControl()
    
    @IBOutlet var loginPage: UIView?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        view.addSubview(scrollView)
        
        automaticallyAdjustsScrollViewInsets = false
        
        scrollView.autoPinEdgesToSuperviewEdges()
        scrollView.backgroundColor = UIColor.red
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.delegate = self
        
        let pages = buildOnboardingPages()
        
        let stackView = UIStackView(arrangedSubviews: pages)
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        scrollView.addSubview(stackView)
        stackView.autoPinEdgesToSuperviewEdges()
        stackView.autoMatch(.height, to: .height, of: view)
        pages.forEach {
            $0.autoMatch(.width, to: .width, of: view)
            $0.autoMatch(.height, to: .height, of: view)
        }
        scrollView.alwaysBounceVertical = false
        
        pagesControl.numberOfPages = pages.count - 1
        pagesControl.pageIndicatorTintColor = UIColor.white
        pagesControl.currentPageIndicatorTintColor = UIColor.yellow
        view.addSubview(pagesControl)
        
        self.pagesControl.autoPinEdge(toSuperviewEdge: .bottom, withInset: 100)
        NSLayoutConstraint.autoSetPriority(UILayoutPriorityDefaultHigh) {
            self.pagesControl.autoAlignAxis(toSuperviewAxis: .vertical)
        }
        self.pagesControl.autoConstrainAttribute(.vertical,
                                                 to: .left,
                                                 of: loginPage!,
                                                 withOffset: -view.bounds.size.width/2,
                                                 relation: .lessThanOrEqual)
    }
    
    func buildOnboardingPages() -> [UIView] {
        let texts = [
            "With our app you can do nothing",
            "Absolutely no features",
            "Your friends will never know"
        ]
        var views = [UIView]()
        for text in texts {
            let view = UIView()
            views.append(view)
            
            let container = UIView()
            container.backgroundColor = UIColor.orange
            view.addSubview(container)
            container.autoPinEdge(toSuperviewEdge: .left, withInset: 40)
            container.autoPinEdge(toSuperviewEdge: .right, withInset: 40)
            container.autoMatch(.height,
                                to: .height,
                                of: view,
                                         withMultiplier: 0.4)
            container.autoAlignAxis(toSuperviewAxis: .horizontal)
            
            let label = UILabel()
            container.addSubview(label);
            label.text = text
            
            label.autoAlignAxis(.horizontal, toSameAxisOf: view)
            label.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
            label.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
            label.numberOfLines = 0
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightSemibold)
            label.textColor = UIColor.white
        }
        Bundle.main.loadNibNamed("LoginPage", owner: self, options: nil)
        if let lp = loginPage {
            views.append(lp)
        }
        return views
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pagesControl.currentPage = Int(scrollView.contentOffset.x / view.bounds.width)
    }
}
