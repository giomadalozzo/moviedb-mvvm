import UIKit

class MovieAPI{
    var localGenresArray: [Genres] = []
    
    func requestGenres(completionHandler: @escaping ([Genres]) -> Void) {
        let urlString = "https://api.themoviedb.org/3/genre/movie/list?api_key=1b312813cf6df1bf51d1ada49057b17d&language=en-US"
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed),
                  let dictionary = json as? [String: Any],
                  let genres = dictionary["genres"] as? [[String: Any]]
            else {
                completionHandler([])
                return
            }
            
            for genreDictionary in genres {
                guard let id = genreDictionary["id"] as? Int,
                      let genre = genreDictionary["name"] as? String
                else { continue }
                
                let genres = Genres(id: id, genre: genre)
                self.localGenresArray.append(genres)
            }
            
            completionHandler(self.localGenresArray)
        }
        .resume()
    }
    
    func requestPopularMovies(completionHandler: @escaping ([Film]) -> Void) {
        let urlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=1b312813cf6df1bf51d1ada49057b17d&language=en-US&page=1"
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            typealias GenericFilm = [String: Any]
            
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed),
                  let dictionary = json as? [String: Any],
                  let films = dictionary["results"] as? [GenericFilm]
            else {
                completionHandler([])
                return
            }
            
            var localFilmsArray: [Film] = []
            
            for filmDictionary in films {
                guard let id = filmDictionary["id"] as? Int,
                      let title = filmDictionary["title"] as? String,
                      let posterPath = filmDictionary["poster_path"] as? String,
                      let overview = filmDictionary["overview"] as? String,
                      let voteAverage = filmDictionary["vote_average"] as? Double,
                      let genres_aux = filmDictionary["genre_ids"] as? [Int],
                      let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)"),
                      let data = try? Data(contentsOf: url),
                      let image = UIImage(data: data)
                else { continue }
                
                var genres = self.genreIdToName(ids: genres_aux)
                let film: Film = Film(id: id, title: title, image: image, overview: overview, voteAverage: voteAverage, genres: genres)
                localFilmsArray.append(film)
            }
            
            completionHandler(localFilmsArray)
        }
        .resume()
    }
    
    func requestNowPlaying(completionHandler: @escaping ([Film]) -> Void){
        let urlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=1b312813cf6df1bf51d1ada49057b17d&language=en-US&page=1"
        
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { (data,response,error) in
            typealias GenericFilm = [String: Any]
            
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed),
                  let dictionary = json as? [String: Any],
                  let films = dictionary["results"] as? [GenericFilm]
            else{
                completionHandler([])
                return
            }
            
            var localFilmsArray: [Film] = []
            
            for filmDictionary in films {
                guard let id = filmDictionary["id"] as? Int,
                      let title = filmDictionary["title"] as? String,
                      let posterPath = filmDictionary["poster_path"] as? String,
                      let overview = filmDictionary["overview"] as? String,
                      let voteAverage = filmDictionary["vote_average"] as? Double,
                      let genres_aux = filmDictionary["genre_ids"] as? [Int],
                      let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)"),
                      let data = try? Data(contentsOf: url),
                      let image = UIImage(data: data)
                else { continue }
                
                var genres = self.genreIdToName(ids: genres_aux)
                let film = Film(id: id, title: title, image: image, overview: overview, voteAverage: voteAverage, genres: genres)
                localFilmsArray.append(film)
            }
        }
        
    }
    
    func genreIdToName(ids: [Int]) -> String {
        var genresString = ""
        for genreId in ids {
            for genre in self.localGenresArray {
                if genre.id == genreId{
                    genresString += genre.genre+", "
                }
            }
        }
        return genresString
    }
}
