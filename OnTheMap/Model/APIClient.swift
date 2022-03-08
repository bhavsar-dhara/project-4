//
//  APIClient.swift
//  OnTheMap
//
//  Created by Dhara Bhavsar on 2021-12-16.
//  Copyright © 2021 Dhara Bhavsar. All rights reserved.
//

import Foundation

class APIClient {
    
    struct Auth {
        static var sessionId = ""
        static var accountKey = ""
    }
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        
        case getStudentLocation
        case createStudentLocation
        case updateStudentLocation
        case handleSession
        case getUserDetails
        
        var stringValue: String {
            switch self {
            case .getStudentLocation: return Endpoints.base + "/StudentLocation"
            case .createStudentLocation: return Endpoints.base + "/StudentLocation"
            case .updateStudentLocation: return Endpoints.base + "/StudentLocation/"
            case .handleSession: return Endpoints.base + "/session"
            case .getUserDetails: return Endpoints.base + "/users/" + ""
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    // handleSession
    class func login(username: String, password: String, completion: @escaping (LoginResponse?, Error?) -> Void) {
        var request = URLRequest(url: Endpoints.handleSession.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // TODO - encoding a JSON body from a string, can also use a Codable struct
        let reqString = "{\"udacity\": {\"username\": \"" + username + "\", \"password\": \"" + password + "\"}}"
         print(reqString)
        request.httpBody = reqString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            print("login: data: ", data!)
//            print("login: decoded data: ", String(data: data!, encoding: .utf8)!)
//            print("login: response: ", response!)
            guard data != nil else { // Handle error…
                // print("login: error: ", error!)
                print("login: Error response received with login http request")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let newData = removeExtraDataFromResponse(originalData: data)
            print(String(data: newData, encoding: .utf8)!)
            let decoder = JSONDecoder()
            var loginResponse: LoginResponse! = LoginResponse()
            do {
                let responseObject = try decoder.decode(SessionDetails.self, from: newData)
                // print("login: responseObject: ", responseObject)
                Auth.sessionId = responseObject.session.id
                Auth.accountKey = responseObject.account.key
                print("login: auth: ", Auth.sessionId, ", ", Auth.accountKey)
                loginResponse.sessionDetails = responseObject
                DispatchQueue.main.async {
                    completion(loginResponse, nil)
                }
            } catch {
                print("login: Error response received with decoding")
                do {
                    let errorResponse = try decoder.decode(ErrorResponse.self, from: newData)
                    print("login: errorResponse: ", errorResponse)
                    loginResponse.errorResponse = errorResponse
                    DispatchQueue.main.async {
                        completion(loginResponse, nil)
                    }
//                    DispatchQueue.main.async {
//                        completion(nil, errorResponse)
//                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }
    
    // handleSession
    class func logout() {
        var request = URLRequest(url: Endpoints.handleSession.url)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        for cookie in HTTPCookieStorage.shared.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                print("Error response received with logout http request")
                return
            }
            let newData = removeExtraDataFromResponse(originalData: data) /* subset response data! */
            print(String(data: newData, encoding: .utf8)!)
        }
        task.resume()
    }
    
    class func getStudentLocation(completion: @escaping ([StudentInformation]?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Endpoints.getStudentLocation.url) { (data, response, error) in
            if error != nil {
                // Handle error...
                print("Error response received with getStudentLocation http request")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            if data != nil {
                print(String(data: data!, encoding: .utf8)!)
                let decoder = JSONDecoder()
                
                do{
                    let response = try
                        decoder.decode(StudentLocation.self, from: data!)
                    print("Data decoded")
                    DispatchQueue.main.async {
                        completion(response.results, nil)
                    }
                } catch {
                    print("Error with the data response received or decoded")
                    DispatchQueue.main.async {
                        completion (nil, error)
                    }
                }
            }
        }
        task.resume()
    }
    
    
    
}

extension APIClient {
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                print("Error = ", data)
//                do {
//                    let errorResponse = try decoder.decode(TMDBResponse.self, from: data) as Error
//                    DispatchQueue.main.async {
//                        completion(nil, errorResponse)
//                    }
//                } catch {
//                    DispatchQueue.main.async {
//                        completion(nil, error)
//                    }
//                }
            }
        }
        task.resume()
        
        return task
    }
    
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                print("Error = ", data)
//                do {
//                    let errorResponse = try decoder.decode(TMDBResponse.self, from: data) as Error
//                    DispatchQueue.main.async {
//                        completion(nil, errorResponse)
//                    }
//                } catch {
//                    DispatchQueue.main.async {
//                        completion(nil, error)
//                    }
//                }
            }
        }
        task.resume()
    }
    
    class func removeExtraDataFromResponse(originalData: Data?) -> Data {
        let range: CountableRange = 5..<originalData!.count
        let newData = originalData?.subdata(in: range)
        return newData!
    }
}
