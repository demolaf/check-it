//
//  OnboardingViewController.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import UIKit

protocol OnboardingView: AnyObject {
    var presenter: OnboardingPresenter? { get set }
}

class OnboardingViewController: UIViewController, OnboardingView {
    var presenter: OnboardingPresenter?
    
    lazy var viewControllers: [UIViewController] = {
        var viewControllers: [OnboardingItemsViewController] = []
        OnboardingInfoList.data.forEach { data in
            let vc = OnboardingItemsViewController()
            vc.configureView(data: data)
            viewControllers.append(vc)
        }
        return viewControllers
    }()
    
    lazy var pageVC: UIPageViewController = {
        let pageVC = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )
        pageVC.setViewControllers(
            [viewControllers.first!],
            direction: .forward,
            animated: true
        )
        pageVC.view.translatesAutoresizingMaskIntoConstraints  = false
        return pageVC
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = 3
        pageControl.numberOfPages = viewControllers.count
        pageControl.addAction(
            UIAction {[weak self] action in
                if let sender = action.sender as? UIPageControl {
                    self?.pageControlTapped(sender)
                }
            },
            for: .valueChanged
        )
        pageControl.currentPageIndicatorTintColor = Asset.Colors.ColorScheme.tertiary.color.light()
        pageControl.pageIndicatorTintColor = Asset.Colors.CustomColors.dotIndicator.color
        return pageControl
    }()
    
    private lazy var getStartedButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get Started", for: .normal)
        button.titleLabel?.font = FontFamily.NunitoSans7pt.bold.font(size: 16)
        button.setTitleColor(
            Asset.Colors.ColorScheme.headline.color.light(),
            for: .normal
        )
        button.backgroundColor = Asset.Colors.ColorScheme.tertiary.color.light()
        button.layer.cornerRadius = 12
        button.addAction(
            UIAction {[weak self] _ in
                self?.presenter?.getStartButtonTapped()
            },
            for: .primaryActionTriggered
        )
        button.layer.shadowColor = Asset.Colors.CustomColors.shadow.color.cgColor
        button.layer.shadowOpacity = 0.15
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowRadius = 5.0
        button.layer.isGeometryFlipped = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViewAppearance()
        initializeSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyConstraints()
    }

    private func initializeViewAppearance() {
        view.backgroundColor = Asset.Colors.ColorScheme.background.color
        navigationItem.hidesBackButton = true
    }
    
    private func initializeSubviews() {
        view.addSubview(pageVC.view)
        view.addSubview(pageControl)
        view.addSubview(getStartedButton)
        initializePageController()
    }
    
    private func initializePageController() {
        pageVC.delegate = self
        pageVC.dataSource = self
        
        addChild(pageVC)
        
        pageVC.didMove(toParent: self)
        view.gestureRecognizers = pageVC.gestureRecognizers
    }
    
    private func applyConstraints() {
        pageVC.view.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(pageControl.snp.top).offset(-24)
        }
        pageControl.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(getStartedButton.snp.top).offset(-56)
        }
        getStartedButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(38)
            make.height.equalTo(44)
        }
    }
}
