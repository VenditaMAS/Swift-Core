//
//  URLRequestBuilder.swift
//  MASCore
//
//  Created by Gregory Higley on 11/30/18.
//  Copyright © 2018 Vendita Technologies, Inc. All rights reserved.
//

import Foundation

/// Greatly simplifies building a `URLRequest`.
public struct URLRequestBuilder: Equatable, ExpressibleByStringLiteral, CustomStringConvertible {
    
    public let scheme: Scheme
    public let host: String
    public let port: Int?
    public var pathSegments: [String] = []
    public var queryItems: Set<QueryItem> = []
    public var headers: Set<Header> = []
    
    public init(scheme: Scheme, host: String, port: Int? = nil, pathSegments: [String] = [], queryItems: Set<QueryItem> = [], headers: Set<Header> = []) {
        self.scheme = scheme
        self.host = host
        self.port = port
        self.pathSegments = pathSegments
        self.queryItems = queryItems
        self.headers = headers
    }
    
    public init?(components: URLComponents) {
        guard let rawScheme = components.scheme, let scheme = Scheme(rawValue: rawScheme) else { return nil }
        guard let host = components.host, host.count > 0 else { return nil }
        let pathSegments: [String] = components.path.split(separator: "/").map(String.init)
        let queryItems: [QueryItem] = (components.queryItems ?? []).map(QueryItem.init)
        var headers: Set<Header> = []
        if let user = components.user, user.count > 0, let password = components.password, password.count > 0 {
            headers.update(with: .authorize(user: user, password: password))
        }
        self.init(scheme: scheme, host: host, port: components.port, pathSegments: pathSegments, queryItems: Set(queryItems), headers: headers)
    }
    
    public init?(url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return nil }
        self.init(components: components)
    }
    
    public init?(string: String) {
        guard let url = URL(string: string) else { return nil }
        self.init(url: url)
    }
    
    public init(stringLiteral value: String) {
        self.init(string: value)!
    }
    
    public var components: URLComponents {
        var components = URLComponents()
        components.scheme = "\(scheme)"
        components.host = host
        components.port = port
        if pathSegments.count > 0 {
            components.path = "/" + pathSegments.joined(separator: "/")
        }
        if queryItems.count > 0 {
            components.queryItems = queryItems.map(\.queryItem)
        }
        return components
    }
    
    public var url: URL {
        return components.url!
    }
    
    public var urlRequest: URLRequest {
        var request = URLRequest(url: url)
        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: "\(header.name)")
        }
        return request
    }
    
    public var description: String {
        return "\(urlRequest)"
    }
}

public extension URLRequestBuilder {
    
    public func with(path pathSegment: String) -> URLRequestBuilder {
        var request = self
        request.pathSegments.append(pathSegment)
        return request
    }
    
    public func with(header: Header) -> URLRequestBuilder {
        var request = self
        request.headers.update(with: header)
        return request
    }
    
    public func with(query queryItem: QueryItem) -> URLRequestBuilder {
        var request = self
        request.queryItems.update(with: queryItem)
        return request
    }
        
}

public protocol HttpMethodBodyPermission {}

public struct BodyRequired: HttpMethodBodyPermission {}
public struct BodyProhibited: HttpMethodBodyPermission {}

public protocol HttpMethod {
    associatedtype BodyPermission: HttpMethodBodyPermission
    static var name: String { get }
}

public struct GET: HttpMethod {
    public typealias BodyPermission = BodyProhibited
    public static let name = "GET"
}

public struct DELETE: HttpMethod {
    public typealias BodyPermission = BodyProhibited
    public static let name = "DELETE"
}

public struct POST: HttpMethod {
    public typealias BodyPermission = BodyRequired
    public static let name = "POST"
}

public struct PATCH: HttpMethod {
    public typealias BodyPermission = BodyRequired
    public static let name = "PATCH"
}

public struct PUT: HttpMethod {
    public typealias BodyPermission = BodyRequired
    public static let name = "PUT"
}

public extension URLRequestBuilder {
    
    public func send<M: HttpMethod>(method: M.Type) -> URLRequest where M.BodyPermission == BodyProhibited {
        var request = urlRequest
        request.httpMethod = method.name
        return request
    }
    
    public func send<M: HttpMethod>(method: M.Type, body: Data) -> URLRequest where M.BodyPermission == BodyRequired {
        var request = urlRequest
        request.httpMethod = method.name
        request.httpBody = body
        return request
    }
    
    public func get() -> URLRequest {
        return send(method: GET.self)
    }
    
    public func delete() -> URLRequest {
        return send(method: DELETE.self)
    }
    
    public func post(_ body: Data) -> URLRequest {
        return send(method: POST.self, body: body)
    }
    
    public func patch(_ body: Data) -> URLRequest {
        return send(method: PATCH.self, body: body)
    }
    
    public func put(_ body: Data) -> URLRequest {
        return send(method: PUT.self, body: body)
    }
}

public extension URLRequestBuilder {

    public enum Scheme: String {
        case http, https
    }
    
}

public extension URLRequestBuilder {
    
    public struct Header: Hashable {
        public let name: Name
        public let value: String
        
        public init(name: Name, value: String) {
            self.name = name
            self.value = value
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(name)
        }
        
        public static func ==(lhs: Header, rhs: Header) -> Bool {
            return lhs.name == rhs.name
        }
        
        public static func accept(_ value: String) -> Header {
            return Header(name: .accept, value: value)
        }
        
        public static func contentType(_ value: String) -> Header {
            return Header(name: .contentType, value: value)
        }
        
        public static func authorize(user: String, password: String) -> Header {
            let basic = "\(user):\(password)".data(using: .utf8)!.base64EncodedString()
            return Header(name: .authorization, value: basic)
        }
    }
    
}

public extension URLRequestBuilder.Header {
    
    public struct Name: ExpressibleByStringLiteral, CustomStringConvertible, Hashable {
        public let description: String
        
        public init(_ name: String) {
            description = name
        }
        
        public init(stringLiteral value: String) {
            description = value
        }
        
        public static let accept: Name = "Accept"
        public static let authorization: Name = "Authorization"
        public static let contentType: Name = "Content-Type"
    }
    
}

public extension URLRequestBuilder {
    
    public struct QueryItem: Hashable {
        public let name: Name
        public let value: String?
        
        public init(name: Name, value: String? = nil) {
            self.name = name
            self.value = value
        }
        
        public init(name: Name, value: Any) {
            self.name = name
            self.value = "\(value)"
        }
        
        public init(queryItem: URLQueryItem) {
            let name = Name(queryItem.name)
            self.init(name: name, value: queryItem.value)
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(name)
        }
        
        public var queryItem: URLQueryItem {
            return URLQueryItem(name: "\(name)", value: value)
        }
        
        public static func ==(lhs: QueryItem, rhs: QueryItem) -> Bool {
            return lhs.name == rhs.name
        }
    }
    
}

public extension URLRequestBuilder.QueryItem {
    
    public struct Name: ExpressibleByStringLiteral, CustomStringConvertible, Hashable {
        public let description: String
        
        public init(_ name: String) {
            description = name
        }
        
        public init(stringLiteral value: String) {
            description = value
        }
    }

    
}

