//
//  HomePresenter.swift
//  MovieCondor
//
//  Created by leonard Borrego on 1/06/22.
//

import Foundation

public protocol HomePresenterType {
    func getMovieList()
    func getToken()
}

public class HomePresenter {
    private var service: NetworkService = NetworkService.shared
    private var token: String?
}

extension HomePresenter: HomePresenterType {
    
    public func getToken(){
        
        service.consumeService(baseUrl: "https://api.themoviedb.org/3/movie/550?api_key=28490dbb804ee88422a684e67782b2db",
                               method: .get) { result in
            switch result {
            case .success(let dictionary):
                print(dictionary)
                break
            case .failure(_):
                break
            }
        }
        
    }
    
    public func getMovieList() {
        
        let model = HomeModel(api_key: service.getApiKey(),
                              language: "en-US",
                              page: 1)
        do {
            try service.consumeService(baseUrl: "https://api.themoviedb.org/3/movie/popular",
                                       method: .get,
                                       parameters: model.asDictionary(), completion: { result in
                switch result {
                case .success(let dictionary):
                    print(dictionary)
                    break
                case .failure(let errorRequest):
                    break
                }
            })
        } catch {
            
        }
    }
}
