//
//  TestBreedViewModelTesting.swift
//  CatsTests
//
//  Created by 김태호 on 2022/08/24.
//

import Combine
import XCTest
@testable import Cats

class TestBreedViewModelTesting: XCTestCase {
    
    private var viewModel: BreedViewModel!
    
    private var mockBreedService: MockBreedsService!
    private var diskCache: DiskCache!
    
    private let saveUrl = FileManager.default.temporaryDirectory.appendingPathComponent("test")
    
    private var cancellable = Set<AnyCancellable>()
    
    /**
     * MARK: - Drop first to ignore the initial value for async (Combine test)
     */
    override func setUp() {
        super.setUp()
        self.mockBreedService = MockBreedsService()
        self.diskCache = DiskCache.shared
        
        self.viewModel = BreedViewModel(
            breedService: mockBreedService,
            diskCache: diskCache
        )
    }
    
    override func tearDown() {
        // Delete all the test data.
        diskCache.removeData(at: saveUrl)
        
        diskCache = nil
        mockBreedService = nil
        viewModel = nil
        super.tearDown()
    }
    
    func test_breedViewModel_start_with_empty_filePath_returns_true() {
        let dataExists = diskCache.fileExists(saveUrl)
        
        let expected = false
        XCTAssertEqual(dataExists, expected)
    }
    
    func test_breedViewModel_fetchData_error_replaced_with_empty_breedModel() {
        mockBreedService.result = Result
            .failure(CommonError.response)
            .publisher
            .eraseToAnyPublisher()
        
        viewModel.fetchBreedsData(at: saveUrl)
        
        let expectation = XCTestExpectation(description: "Test is set to error")
        viewModel.$breeds.dropFirst().sink { result in
            expectation.fulfill()
        }
        .store(in: &cancellable)
        
        wait(for: [expectation], timeout: 3)
        
        XCTAssertTrue(viewModel.breeds.isEmpty)
    }
    
    func test_breedViewModel_fetchData_success_get_empty_breed_model_and_not_save_data_at_disk() {
        mockBreedService.result = Result
            .success([])
            .publisher
            .eraseToAnyPublisher()
        
        viewModel.fetchBreedsData(at: saveUrl)
        
        let expectation = XCTestExpectation(description: "Test is set to success returns empty breed model")
        viewModel.$breeds.dropFirst().sink { result in
            expectation.fulfill()
        }
        .store(in: &cancellable)
        
        wait(for: [expectation], timeout: 3)
        
        XCTAssertTrue(viewModel.breeds.isEmpty)
        
        let dataSaved = diskCache.fileExists(saveUrl)
        XCTAssertEqual(dataSaved, false)
    }
    
    func test_breedViewModel_fetchData_success_get_breed_models_and_save_data_at_disk() {
        mockBreedService.result = Result
            .success([.staticBreedModel, .staticBreedModel])
            .publisher
            .eraseToAnyPublisher()
        
        viewModel.fetchBreedsData(at: saveUrl)
        
        let expectation = XCTestExpectation(description: "Test is set to success returns breed models")
        viewModel.$breeds.dropFirst().sink { result in
            expectation.fulfill()
        }
        .store(in: &cancellable)
        
        wait(for: [expectation], timeout: 3)
        
        XCTAssertEqual(viewModel.breeds, [.staticBreedModel, .staticBreedModel])
        
        let dataSaved = diskCache.fileExists(saveUrl)
        XCTAssertEqual(dataSaved, true)
    }
    
func test_breedViewModel_load_breed_models_from_disk() {
        let breedModels: [BreedModel] = [.staticBreedModel, .staticBreedModel]
        viewModel.saveBreedsDataOnDisk(breeds: breedModels, at: saveUrl)
        
        viewModel.loadBreedModelsFromDisk(from: saveUrl)
        
        XCTAssertEqual(viewModel.breeds, [.staticBreedModel, .staticBreedModel])
    }
}
