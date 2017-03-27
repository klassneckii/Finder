//
//  NetworkClient.swift
//  Finder
//
//  Created by Dmitry Parzhetsky on 20/03/2017.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

typealias NetworkClientResult = () throws -> Data
typealias NetworkClientCompletion = (_ result: @escaping NetworkClientResult) -> Void

/// Протокол сетевого клиента
protocol NetworkClient {
    func perform(request: URLRequest, completion: NetworkClientCompletion?)
}
