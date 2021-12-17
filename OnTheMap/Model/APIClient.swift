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
        case createSession
        case deleteSession
        case getUserDetails
        
        var stringValue: String {
            switch self {
            case .getStudentLocation: return Endpoints.base + "/StudentLocation"
            case .createStudentLocation: return Endpoints.base + "/StudentLocation"
            case .updateStudentLocation: return Endpoints.base + "/StudentLocation/"
            case .createSession: return Endpoints.base + ""
            case .deleteSession: return Endpoints.base + ""
            case .getUserDetails: return Endpoints.base + "/users/"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func getStudentLocation(completion: @escaping ([LocationResult]?, Error?) -> Void) {
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
