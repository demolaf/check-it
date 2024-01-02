//
//  OnboardingInfoList.swift
//  check_it
//
//  Created by Ademola Fadumo on 02/01/2024.
//

import Foundation

struct OnboardingInfoList {
    static let data: [OnboardingData] = [
        OnboardingData(
            title: "Welcome to CheckIT",
            subitle: "Seamlessly Explore, Collaborate, and Elevate Your Projects",
            image: Asset.Assets.OnboardingImages.onboarding1.name
        ),
        OnboardingData(
            title: "Exploring Possibilities",
            subitle: "Navigate, Collaborate, and Create with CheckIT",
            image: Asset.Assets.OnboardingImages.onboarding2.name
        ),
        OnboardingData(
            title: "Enhance Your GitHub Journey",
            subitle: "Effortless Innovation and Collaboration Awaits with CheckIT",
            image: Asset.Assets.OnboardingImages.onboarding3.name
        )
    ]
}
