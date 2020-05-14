//
//  RadioViewController.swift
//  Course2Week4Task1
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit

class RadioViewController: UIViewController {
    
    private var portraitConstraints: [NSLayoutConstraint] = []
    private var landscapeConstraints: [NSLayoutConstraint] = []
    private var sharedConstraints: [NSLayoutConstraint] = []
    private var sideInset: CGFloat { return 16 }
    
    private let albumCoverImageView: UIImageView  = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image")
        imageView.contentMode = .scaleAspectFill
        imageView.disableAutoresizingMask()
        return imageView
    }()
    
    private let playbackProgress: UIProgressView = {
        let progress = UIProgressView()
        progress.progressViewStyle = .default
        progress.setProgress(0.5, animated: true)
        progress.disableAutoresizingMask()
        return progress
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font.withSize(22)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "Aerosmith - Hole In My Soul"
        label.disableAutoresizingMask()
        return label
    }()
    
    private let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.maximumValue = 1.0
        slider.minimumValue = 0.0
        slider.setValue(0.5, animated: true)
        slider.disableAutoresizingMask()
        return slider
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.disableAutoresizingMask()
        return view
    }()
    
    private let titleContainerView: UIView = {
        let view = UIView()
        view.disableAutoresizingMask()
        return view
    }()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        NSLayoutConstraint.activate(sharedConstraints)
        layoutTrait(traitCollection: UIScreen.main.traitCollection)
    }
    
    // MARK: - Layout
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(containerView)
        containerView.addSubviews(albumCoverImageView, playbackProgress, volumeSlider, titleContainerView)
        titleContainerView.addSubview(titleLabel)
    }
    
    private func layoutTrait(traitCollection: UITraitCollection) {
        let needDeactivatePortrait =
            !portraitConstraints.isEmpty && portraitConstraints.first?.isActive ?? false
        let needDeactivateLandscape =
            !landscapeConstraints.isEmpty && landscapeConstraints.first?.isActive ?? false
        
        if !(sharedConstraints.first?.isActive ?? true) {
           NSLayoutConstraint.activate(sharedConstraints)
        }
        
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            if needDeactivateLandscape {
                NSLayoutConstraint.deactivate(landscapeConstraints)
            }
            NSLayoutConstraint.activate(portraitConstraints)
        } else {
            if needDeactivatePortrait {
                NSLayoutConstraint.deactivate(portraitConstraints)
            }

            NSLayoutConstraint.activate(landscapeConstraints)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        layoutTrait(traitCollection: traitCollection)
    }

}

extension RadioViewController {
    
    private func setupConstraints() {
        sharedConstraints.append(contentsOf: [
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: sideInset),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sideInset),

            albumCoverImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            albumCoverImageView.heightAnchor.constraint(equalTo: albumCoverImageView.widthAnchor),

            playbackProgress.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            playbackProgress.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            playbackProgress.heightAnchor.constraint(equalToConstant: 2),
            
            volumeSlider.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            volumeSlider.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            volumeSlider.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            
            titleContainerView.topAnchor.constraint(equalTo: playbackProgress.bottomAnchor, constant: 31/2),
            titleContainerView.bottomAnchor.constraint(equalTo: volumeSlider.topAnchor),
            
            titleLabel.centerYAnchor.constraint(equalTo: titleContainerView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor)
        ])

        landscapeConstraints.append(contentsOf: [
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: sideInset),
            playbackProgress.topAnchor.constraint(equalTo: containerView.topAnchor),
            albumCoverImageView.topAnchor.constraint(equalTo: playbackProgress.bottomAnchor, constant: sideInset),
            albumCoverImageView.bottomAnchor.constraint(equalTo: volumeSlider.topAnchor, constant: -16),
            titleContainerView.leadingAnchor.constraint(equalTo: albumCoverImageView.trailingAnchor, constant: sideInset),
            titleContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -sideInset)
        ])

        portraitConstraints.append(contentsOf: [
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            albumCoverImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            albumCoverImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            playbackProgress.topAnchor.constraint(equalTo: albumCoverImageView.bottomAnchor, constant: 30),
            titleContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
}

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    func disableAutoresizingMask() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
