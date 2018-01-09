import Foundation

struct SearchResponse: Codable {
    let hits: Int
    let items: [SearchResponseItem]
}

struct SearchResponseItem: Codable {
    let title: String
    let snippet: String
    let ts: Double
    let lastAuthor: Int
    let channelId: Int

    enum CodingKeys: String, CodingKey {
        case title
        case snippet
        case ts = "last_posted_ts"
        case lastAuthor = "last_author"
        case channelId = "channel_id"
    }
}
