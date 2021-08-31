import Foundation
import Alamofire

struct DataServices {
    
    // MARK: - GET
    static func getRepoSearchList(query: String) -> Endpoint<GithubRes> {
        let querys: RepoQuery = RepoQuery(q: query)
        return Endpoint(path: "search/repositories",
                        method: .get,
                        headerParamaters: ["Content-Type": "application/json"],
                        queryParametersEncodable: querys)
    }
    
    // static func getMoviePoster(path: String, width: Int) -> Endpoint<Data> {
    
    //     let sizes = [92, 154, 185, 342, 500, 780]
    //     let closestWidth = sizes.enumerated().min { abs($0.1 - width) < abs($1.1 - width) }?.element ?? sizes.first!
    
    //     return Endpoint(path: "t/p/w\(closestWidth)\(path)",
    //         method: .get,
    //         responseDecoder: RawDataResponseDecoder())
    // }
}
