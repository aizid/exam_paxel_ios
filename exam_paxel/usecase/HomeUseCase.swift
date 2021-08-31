import Foundation

protocol HomeUseCase {
    func getRepoSearchList(query: String, completion: @escaping (Result<GithubRes, Error>) -> Void) -> Cancellable?
}

final class DefaultHomeUseCase: HomeUseCase {
    
    private let examRepository: ExamRepository
    
    init(examRepository: ExamRepository) {
        self.examRepository = examRepository
    }
    
    func getRepoSearchList(query: String, completion: @escaping (Result<GithubRes, Error>) -> Void) -> Cancellable? {
        return examRepository.getRepoSearchList(query: query, completion: { result in
            if case .success = result {
                completion(result)
            }
        })
    }
}

