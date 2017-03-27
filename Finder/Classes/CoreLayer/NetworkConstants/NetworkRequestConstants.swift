//
//  NetworkRequestConstants.swift
//  Finder
//
//  Created by Dmitry Parzhetsky on 20/03/2017.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

/**
 Network constants enumeration.
 */
enum NetworkRequestConstants {
    
    /**
        Network request headers.
     
         - contentType: Request content-type
         - accept: Request accept
     */
    enum HeaderName: String {
        case contentType = "Content-Type"
        case accept = "Accept"
    }
    
    /**
     Network request HTTP Method.
     */
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    /**
     Base API Path urls
     */
    enum APIPath: String {
        case iTunesPath = "https://itunes.apple.com/"
        case gitHubPath = "https://api.github.com/"
    }
    
    /// Методы, существующие в API
    enum APIMethodName: String {
        case itunesSearch = "search/"
        case githubUserSearch = "search/users"
    }
    
    /**
     Request builder error
     */
    enum RequestBuilderError: Error {
        case incorrectUrlPath
        case urlConfigurationParserNotImplemented
    }
    
    enum URLFields {
        struct ITunes {
            struct Search {
                static let term = "term"
            }
        }
        struct Github {
            struct Search {
                static let term = "q"
            }
        }  
    }
}
