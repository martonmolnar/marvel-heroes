//
//  HeroesListAPI.swift
//  Core
//
//  Created by Molnar Marton on 2022. 05. 15..
//
public struct Heroes {
    public enum Hero {}
}
extension Heroes.Hero {
public enum GetHeroesList {

    public static let service = APIService<Response>(id: "characters", tag: "characters", method: "GET", path: "/v1/public/characters", hasBody: false, securityRequirements: [SecurityRequirement(type: "ApiKeyAuth", scopes: [])])

    public final class Request: APIRequest<Response> {

        public init() {
            super.init(service: GetHeroesList.service)
        }

        public override var queryParameters: [String: Any] {
            var params: [String: Any] = [:]
              params["apikey"] = "bef2a08eac53f8c6166af12de364ccad"
              params["ts"] = "1"
              params["hash"] = "370e791ac6d85c7c8f079cc225268753"
            return params
        }
    }

    public enum Response: APIResponseValue, CustomStringConvertible, CustomDebugStringConvertible {
        public typealias SuccessType = HeroesListApiModel

        /** Successful operation. */
        case status200(HeroesListApiModel)

        public var success: HeroesListApiModel? {
            switch self {
            case .status200(let response): return response
            default: return nil
            }
        }

        public var respResult: APIResponseResult<HeroesListApiModel, ErrorMessageResponseApiModel> {
            if let successValue = success {
                return .success(successValue)
            } else {
                fatalError("Response does not have success or failure response")
            }
        }

        public var response: Any {
            switch self {
            case .status200(let response): return response
            }
        }

        public var statusCode: Int {
            switch self {
            case .status200: return 200
            }
        }

        public var successful: Bool {
            switch self {
            case .status200: return true
            }
        }

        public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
            switch statusCode {
            case 200: self = try .status200(decoder.decode(HeroesListApiModel.self, from: data))
            default: throw APIClientError.unexpectedStatusCode(statusCode: statusCode, data: data)
            }
        }

        public var description: String {
            return "\(statusCode) \(successful ? "success" : "failure")"
        }

        public var debugDescription: String {
            var string = description
            let responseString = "\(response)"
            if responseString != "()" {
                string += "\n\(responseString)"
            }
            return string
        }
    }
}

}
