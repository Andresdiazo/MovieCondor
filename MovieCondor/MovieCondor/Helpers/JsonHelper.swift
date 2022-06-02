//
//  JsonHelper.swift
//  MovieCondor
//
//  Created by leonard Borrego on 1/06/22.
//

import Foundation

extension Dictionary {
    /**
     *  Comvert from `Dictionary` to `Codable`.
     *
     *  - Returns:Dictionary object as Codable
     */
    func deserialize<T>(type: T.Type) -> T? where T: Codable {
        do {
            let data = try JSONSerialization.data(withJSONObject: self,
                                                         options: .prettyPrinted)
            return try JSONDecoder().decode(type, from: data)
        } catch let error {
            print(">> Error Get/Parese as Data Custom =\(error) !!")
        }
        return nil
    }
    
}

extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
}
