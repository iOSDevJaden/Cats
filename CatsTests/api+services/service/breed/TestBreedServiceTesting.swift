//
//  TestBreedServiceTesting.swift
//  CatsTests
//
//  Created by 김태호 on 2022/08/15.
//

import Combine
import XCTest
@testable import Cats

class TestBreedServiceTesting: XCTestCase {
    
    var mockBreedService: MockBreedsService!
    var cancellable = Set<AnyCancellable>()
    
    override func setUp() {
        mockBreedService = MockBreedsService()
    }
    
    override func tearDown() {
        mockBreedService = nil
    }
    
    func test_mock_breed_service_returns_success() {
        let expected = [BreedModel.staticBreedModel]
        
        mockBreedService.result = Result
            .success([BreedModel.staticBreedModel])
            .publisher
            .eraseToAnyPublisher()
        
        mockBreedService.getBreeds()
            .replaceError(with: [])
            .sink { breedModel in
                XCTAssertEqual(breedModel, expected)
            }
            .store(in: &self.cancellable)
    }
    
    func test_mock_breed_service_returns_failure() {
        let expected = CommonError.response
        
        mockBreedService.result = Result
            .failure(CommonError.response)
            .publisher
            .eraseToAnyPublisher()
        
        mockBreedService.getBreeds()
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .failure(let err):
                        let resultError = err as! CommonError
                        XCTAssertEqual(expected, resultError)
                    case .finished:
                        print("Finished")
                    }
                },
                receiveValue: { _ in })
            .store(in: &self.cancellable)
    }
    
    func test_mock_breed_service_get_breeds_by_id_returns_breed_models() {
        let expected = [BreedModel.staticBreedModel]
        
        mockBreedService.result = Result
            .success([BreedModel.staticBreedModel])
            .publisher
            .eraseToAnyPublisher()
        
        mockBreedService.getBreeds(by: "abys")
            .replaceError(with: [])
            .sink { breedModel in
                XCTAssertEqual(breedModel, expected)
            }
            .store(in: &self.cancellable)
    }
    
    func test_mock_breed_service_get_breeds_by_id_returns_common_response_error() {
        let expected = CommonError.response

        mockBreedService.result = Result
            .failure(CommonError.response)
            .publisher
            .eraseToAnyPublisher()
        
        mockBreedService.getBreeds(by: "not registered cat")
            .sink (
                receiveCompletion: { result in
                    switch result {
                    case .failure(let err):
                        let resultError = err as! CommonError
                        XCTAssertEqual(expected, resultError)
                    case .finished:
                        print("Finished")
                    }
                },
                receiveValue: { _ in })
            .store(in: &self.cancellable)
    }
    
}
