import Foundation

protocol ExamRepository {
    //    @discardableResult
    //    func fetchMoviesList(query: MovieQuery, page: Int,
    //                         cached: @escaping (MoviesPage) -> Void,
    //                         completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable?
    
    // POST
    
    // ==============
    
    // GET
    @discardableResult
    func getRepoSearchList(query: String, completion: @escaping (Result<GithubRes, Error>) -> Void) -> Cancellable?
    
    //  func fetchImage(with imagePath: String, width: Int, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable?
    
    // ===============
    
    // PUT
    
}

