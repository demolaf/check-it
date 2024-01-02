//
//  OnboardingInteractor.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import Foundation

protocol OnboardingInteractor: AnyObject {
     var presenter: OnboardingPresenter? { get set }
}

class OnboardingInteractorImpl: OnboardingInteractor {
    var presenter: OnboardingPresenter?
}
