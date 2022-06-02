//
//  HomeModel.swift
//  MovieCondor
//
//  Created by leonard Borrego on 1/06/22.
//

import Foundation

struct HomeModel: Codable {
    var api_key: String
    var language: String
    var page: Int
    var region: String?

    public init(api_key: String, language: String, page: Int, region: String? = ""){
        self.api_key = api_key
        self.language = language
        self.page = page
        self.region = region
    }
}
