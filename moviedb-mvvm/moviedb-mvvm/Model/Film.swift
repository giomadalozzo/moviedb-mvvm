import UIKit

struct Film: CustomStringConvertible{
    let id: Int
    let title: String
    let image: UIImage
    let overview: String
    let voteAverage: Double
    let genres: String
    
    var description: String {
        return "ID: \(id), Title: \(title), Overview: \(overview), Vote: \(voteAverage) \n"
    }
}
