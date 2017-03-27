//
//  NetworkClientImplementation.swift
//  Finder
//
//  Created by Dmitry Parzhetsky on 20/03/2017.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import Foundation

/// Типы ошибок сетевого клиента
///
/// - EmptyDataReturned: Данные ответа на сетевой запрос пусты при отсутствии ошибки соединения.
enum NetworkClientError: Error {
    case emptyDataReturned
}

/// Cетевой клиент.
class NetworkClientImplementation: NetworkClient {
    private let session: URLSession
    
    // MARK: Конструкторы
    
    init(session: URLSession) {
        self.session = session
    }
    
    // MARK: - Методы протокола NetworkClient
    
    func perform(request: URLRequest, completion: NetworkClientCompletion?) {
        let dataTask = session.dataTask(with: request) { data, response, error in
            
            completion? {
                if let networkError = error {
                    throw networkError
                }
                
                guard let responseData = data else {
                    throw NetworkClientError.emptyDataReturned
                }
                
                return responseData
            }
        }
        dataTask.resume()
    }
}
