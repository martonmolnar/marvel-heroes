//
//  HTTPRequestHeaderProviderInterface.swift
//  Core
//
//  Created by Molnar Marton on 2022. 05. 16..
//

import Common

public typealias NetworkingHTTPHeaders = [String: String]

enum HTTPHeader: String {
    /// Headers
    case accept = "Accept"
    case acceptCharset = "Accept-Charset"
    case acceptLanguage = "Accept-Language"
    case applicationId = "ApplicationId"
    case authorization = "Authorization"

    /// Custom headers
    case xLogParameter = "X-Log-Parameters"
    case xSourceChannel = "X-Source-Channel"
    case xClientFunction = "X-Client-Function"

    /// Service specific headers
    case psuDeviceId = "PSU-Device-ID"
    case psuDeviceOs = "PSU-Device-OS"
}

protocol HTTPRequestHeaderProviderInterface{
    func provideHeader(for headerKey: HTTPHeader) -> NetworkingHTTPHeaders?
    func provideHeaders(for headerKeys: [HTTPHeader]) -> NetworkingHTTPHeaders?
}
