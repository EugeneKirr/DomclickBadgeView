//
//  BadgeCountView.swift
//  DomclickBadgeCountView
//
//  Created by Eugene Kireichev on 07.11.2020.
//

import UIKit

protocol TapActionDelegate: class {
    func performOnTapAction()
}

protocol ViewModelSettable {
    func setupViewModel(_ viewModel: BadgeCountViewModel)
}

struct BadgeCountViewModel {
    let count: Int?
    let image: UIImage?
    let delegate: TapActionDelegate?
    
    init(count: Int? = nil,
         image: UIImage? = nil,
         delegate: TapActionDelegate? = nil) {
        self.count = count
        self.image = image
        self.delegate = delegate
    }
}

class BadgeCountView: UIView {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var countLabel: UILabel!
    
    private weak var delegate: TapActionDelegate?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        setupContentView()
        setupBadgeCount()
        setupGesture()
    }
    
    private func setupGesture() {
        let pressGesture = UILongPressGestureRecognizer(target: self, action: #selector(onViewTapped(sender:)))
        pressGesture.delegate = self
        pressGesture.minimumPressDuration = 0.1
        addGestureRecognizer(pressGesture)
    }
    
    @objc
    private func onViewTapped(sender: UITapGestureRecognizer) {
        switch sender.state {
        case .began:
            animateTapBegan()
        case .ended:
            animateTapEnded()
            delegate?.performOnTapAction()
        default:
            return
        }
    }
    
    private func animateTapBegan() {
        UIView.animate(withDuration: 0.1) {
            self.imageView.alpha = 0.5
        }
    }
    
    private func animateTapEnded() {
        UIView.animate(withDuration: 0.1) {
            self.imageView.alpha = 1.0
        }
    }
    
    private func setupContentView() {
        guard let view = UINib(nibName: "BadgeCountView", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView else { return }
        view.frame = frame
        addSubview(view)
    }
    
    private func setupBadgeCount() {
        countLabel.layoutIfNeeded()
        countLabel.font = UIFont.systemFont(ofSize: bounds.height / 3, weight: UIFont.Weight.bold)
        countLabel.textAlignment = .center
        countLabel.layer.cornerRadius = countLabel.bounds.height / 2
        countLabel.clipsToBounds = true
    }
    
}

extension BadgeCountView: ViewModelSettable {
    func setupViewModel(_ viewModel: BadgeCountViewModel) {
        if let count = viewModel.count, count > 0 {
            countLabel.text = "\(count)"
            countLabel.isHidden = false
        } else {
            countLabel.isHidden = true
        }
        
        imageView.image = viewModel.image
        delegate = viewModel.delegate
    }
}

extension BadgeCountView: UIGestureRecognizerDelegate {}
