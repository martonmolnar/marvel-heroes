//
//  DefaultApiClientService.swift
//  Core
//
//  Created by Molnar Marton on 2022. 05. 16..
//

import RxSwift
import Alamofire

final class DefaultApiClientService {
    private let apiClient: APIClient

    init(baseURL: String) {

        /// URLSessionConfiguration setup
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = 60
        sessionConfiguration.timeoutIntervalForResource = 60
        sessionConfiguration.httpMaximumConnectionsPerHost = 50
        sessionConfiguration.tlsMinimumSupportedProtocol = .tlsProtocol12

        let interceptor = Interceptor(adapters: [],
                                      retriers: [],
                                      interceptors: [])

        /// Session
        let session = Session(configuration: sessionConfiguration,
                              interceptor: interceptor)

        self.apiClient = APIClient(
            baseURL: baseURL,
            session: session,
            defaultHeaders: Constants.defaultHeader
        )
    }
}

extension DefaultApiClientService: ApiClientServiceInterface {
    func makeRequest<T>(_ request: APIRequest<T>, behaviours: [RequestBehaviour]) -> Single<T> {
        return Single.create { [apiClient] single -> Disposable in
            apiClient.makeRequest(request, behaviours: behaviours) { response in
                switch response.result {
                case .success(let responseValue):
                    single(.success(responseValue))
                case .failure(let error):
                    single(.failure(error))
                }
            }

            return Disposables.create()
        }
    }
}

private extension DefaultApiClientService {
    // MARK: - Constants
    private enum Constants {
        static let defaultHeader: [String: String] = ["Accept": "*/*"]
    }
}
