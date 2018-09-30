//
//  CountriesNetwork.swift
//  Countries
//
//  Created by Anastasia Loginova on 9/28/18.
//  Copyright © 2018 loginova. All rights reserved.
//

import Foundation
import Moya

enum NetworkManager {
    case all
    case detail(name: String)
}

extension NetworkManager: TargetType {
    var headers: [String : String]? {
        return nil
    }
    
    var baseURL: URL {
        return URL(string: "https://restcountries.eu/rest/v2/")!
    }
    
    var path: String {
        switch self {
        case .all:
            return "all"
        case .detail(let name):
            return "name/" + name
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var sampleData: Data {
        switch self {
        case .all, .detail:
            return "".data(using: .utf8)!
        }
    }
    
    var task: Task {
        return .requestPlain
    }
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
