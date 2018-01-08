import Foundation

struct SearchResults {
    /// The query string that generated these results
    let query: String
    /// When the search that generated these results was run
    let ts: Date
    /// Result items
    let items: [ResultItem]
}

struct ResultItem {
    /// The item's title
    let title: String
    /// The item's contents
    let contents: String
    /// The item's timestamp
    let ts: Date
}
