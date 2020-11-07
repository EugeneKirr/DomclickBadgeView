//
//  ViewController.swift
//  DomclickBadgeCountView
//
//  Created by Eugene Kireichev on 07.11.2020.
//

import UIKit

class ViewController: UIViewController {
    
    private var count = 0 {
        didSet {
            updateBadgeView()
        }
    }
    private var image = UIImage(systemName: "bell.fill")
    private var badgeView: BadgeCountView? {
        didSet {
            updateBadgeView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.navigationBar.tintColor = UIColor.white
        title = "BadgeCount"
        
        let defaultRightButton = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(onRightButtonTap)
        )
        navigationItem.rightBarButtonItem = defaultRightButton
        
        badgeView = BadgeCountView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        
        let customRightButton = UIBarButtonItem(customView: badgeView ?? UIView())
        navigationItem.rightBarButtonItems?.append(customRightButton)
    }
    
    @objc
    private func onRightButtonTap() {
        count += 1
    }
    
    private func updateBadgeView() {
        let vm = BadgeCountViewModel(count: count, image: image, delegate: self)
        badgeView?.setupViewModel(vm)
    }

}

extension ViewController: TapActionDelegate {
    func performOnTapAction() {
        count = 0
    }
}

