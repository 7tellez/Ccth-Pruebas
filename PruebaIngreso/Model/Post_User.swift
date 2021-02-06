//
//  Post_User.swift
//  PruebaIngreso
//
//  Created by Camilo Téllez on 4/02/21.
//

import Foundation

// MARK: - PostUser
class PostUser: Codable {
    var userID, id: Int?
    var title, body: String?

    init(userID: Int?, id: Int?, title: String?, body: String?) {
        self.userID = userID
        self.id = id
        self.title = title
        self.body = body
    }
}
