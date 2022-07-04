//
//  DataModels.swift
//  KitmanLabs
//

import Foundation

public struct Athlete: Codable {
    var firstName: String
    var lastName: String
    var id: Int
    var image: Image
    var username: String
    var squadIds: [Int]
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case id
        case image
        case username
        case squadIds = "squad_ids"
    }
}

public struct Image: Codable {
    var url: String
}

public struct Squad: Codable {
    var createdAt: String
    var id: Int
    var name: String
    var organisationId: Int
    var updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case id
        case name
        case organisationId = "organisation_id"
        case updatedAt = "updated_at"
    }
}

public struct User: Codable {
    var username: String
}

public struct PlayerDetails: Codable {
    var playerName: String
    var username: String
    var squad: String
    var url: String
}
