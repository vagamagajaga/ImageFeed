
import Foundation

struct UserProfileResult: Codable {
    let username: String
    let firstName: String
    let lastName: String
    let bio: String
    
    enum CodingKeys: String, CodingKey {
        case username = "username"
        case firstName = "first_name"
        case lastName = "last_name"
        case bio = "bio"
    }
}

struct Profile {
    let username: String
    let name: String
    let loginName: String
    let bio: String?
    
    init(from result: UserProfileResult) {
        self.username = result.username
        self.loginName = "@" + result.username
        self.bio = result.bio
        self.name = result.firstName + " " + result.lastName
    }
}


