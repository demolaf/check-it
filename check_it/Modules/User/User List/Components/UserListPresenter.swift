//
//  UserListPresenter.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import Foundation

protocol UserListPresenter: AnyObject {
    var view: UserListView? { get set }
    var interactor: UserListInteractor? { get set }
    var router: UserListRouter? { get set }
    var hasMoreData: Bool { get set }
    var isPaginating: Bool { get set }
    var currentPage: Int { get set }
    
    func initialize()
    func interactorDidFetch(for repos: Result<[PublicRepositoryListResponse], APIError>)
    func fetchRepos()
    func navigateToUserDetails(repo: PublicRepositoryListResponse)
}

class UserListPresenterImpl: UserListPresenter {
    var router: UserListRouter?
    var interactor: UserListInteractor?
    var view: UserListView?
    
    var currentPage: Int = 0
    var hasMoreData: Bool = false
    var isPaginating: Bool = false
    var repos: [PublicRepositoryListResponse] = []
    
    func initialize() {
        Task {
            await interactor?.getPublicReposList()
        }
    }
    
    func interactorDidFetch(for repos: Result<[PublicRepositoryListResponse], APIError>) {
        // Reset Pagination
        currentPage = 0
        view?.items.accept([])
        switch repos {
        case .success(let repos):
            self.repos = repos
            fetchRepos()
        case .failure:
            view?.showErrorAlert()
        }
    }
    
    func fetchRepos() {
        isPaginating = true
        
        let itemsPerPage = 10
        let startIndex = currentPage * itemsPerPage
        let endIndex = min(startIndex + itemsPerPage, self.repos.count)
        
        
        var currentList: [PublicRepositoryListResponse] = view?.items.value ?? []
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let newFetchedList = Array(self.repos[startIndex..<endIndex])
            
            if newFetchedList.isEmpty {
                debugPrint("No more data")
                self.isPaginating = false
                self.hasMoreData = false
                return
            } else {
                self.hasMoreData = true
            }
            
            debugPrint("Current list \(currentList), New list \(newFetchedList)")
            currentList.append(contentsOf: newFetchedList)
            self.view?.items.accept(currentList)
            self.isPaginating = false
            self.currentPage += 1
            debugPrint("Current page \(self.currentPage)")
        }
    }
    
    func navigateToUserDetails(repo: PublicRepositoryListResponse) {
        router?.navigateToUserDetails(repo: repo)
    }
}
