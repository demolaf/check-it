//
//  HTTPClient.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import Foundation

protocol HTTPClient {
    /// GET Method
    @discardableResult
    func get<ResponseType: Decodable>(
        url: URL?,
        headers: [String: String]?,
        response: ResponseType.Type
    ) async -> Result<ResponseType, APIError>

    /// POST Method
    @discardableResult
    func post<RequestType: Encodable, ResponseType: Decodable>(
        url: URL?,
        headers: [String: String]?,
        body: RequestType,
        response: ResponseType.Type
    ) async -> Result<ResponseType, APIError>
}
