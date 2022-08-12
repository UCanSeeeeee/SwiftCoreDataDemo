//
//  APICaller.swift
//  1stCoreData
//
//  Created by 王杰 on 2022/8/12.
//

//import Foundation
//
//enum APIError: Error {
//    case failedTogetData
//}
//
//class APICaller {
//    static let shared = APICaller()
//    func getMovies((completion: @escaping (Result<[CoreDataItem], Error>) -> Void)) {
//        guard let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=697d439ac993538da4e3e60b54e762cd") else {
//            return
//        }
//        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
//            guard let data = data, error == nil else {
//                return
//            }
//            do {
//                let results = try JSONDecoder().decode(CoreDataItemModel.self, from: data)
//                completion(.success(results.results))
//            }
//            catch {
//                completion(.failure(APIError.failedTogetData))
//            }
//        }
//        task.resume()
//    }
//}
