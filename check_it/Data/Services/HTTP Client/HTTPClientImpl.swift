//
//  HTTPClientImpl.swift
//  check_it
//
//  Created by Ademola Fadumo on 01/01/2024.
//

import Foundation

class HTTPClientImpl: HTTPClient {
    func get<ResponseType: Decodable>(
        url: URL?,
        headers: [String: String]?,
        response: ResponseType.Type
    ) async -> Result<ResponseType, APIError> {
        guard let url = url else {
            return .failure(.failedToFetchData)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        headers?.forEach { (key: String, value: String) in
            request.addValue(value, forHTTPHeaderField: key)
        }

        do {
            let (data, _)  = try await URLSession.shared.data(from: url)
            let responseObject = try JSONDecoder().decode(ResponseType.self, from: data)
            return .success(responseObject)
        } catch {
            debugPrint("Error \(error)")
            return .failure(.failedToFetchData)
        }
    }

    func post<RequestType: Encodable, ResponseType: Decodable>(
        url: URL?,
        headers: [String: String]?,
        body: RequestType,
        response: ResponseType.Type
    ) async -> Result<ResponseType, APIError> {
        guard let url = url else {
            return .failure(.failedToSendData)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        headers?.forEach { (key: String, value: String) in
            request.addValue(value, forHTTPHeaderField: key)
        }
        request.httpBody = try! JSONEncoder().encode(body)

        do {
            let (data, _)  = try await URLSession.shared.data(for: request)
            let responseObject = try JSONDecoder().decode(ResponseType.self, from: data)
            return .success(responseObject)
        } catch {
            return .failure(.failedToSendData)
        }
    }
}
