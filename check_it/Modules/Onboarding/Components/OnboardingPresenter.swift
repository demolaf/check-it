//
//  OnboardingPresenter.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import Foundation

protocol OnboardingPresenter: AnyObject {
    var view: OnboardingView? { get set }
    var interactor: OnboardingInteractor? { get set }
    var router: OnboardingRouter? { get set }

    func getStartButtonTapped()
}

class OnboardingPresenterImpl: OnboardingPresenter {
    var router: OnboardingRouter?
    var interactor: OnboardingInteractor?
    var view: OnboardingView?
    
    func getStartButtonTapped() {
        router?.navigateToUserList()
    }
}
