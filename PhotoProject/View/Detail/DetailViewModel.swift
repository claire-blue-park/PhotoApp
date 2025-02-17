//
//  DetailViewModel.swift
//  PhotoProject
//
//  Created by Claire on 2/10/25.
//

import Foundation

final class DetailViewModel: BaseViewModel {
    
    var input: Input
    var output: Output
    
    struct Input {
        var result: Observable<Results?> = Observable(nil)
    }
    
    struct Output {
        var result: Observable<Results?> = Observable(nil)
        var postDateInfo: String = ""
        var imageInfo: Observable<ImageInfo?> = Observable(nil)
        var errorMessage: String = ""
    }
    
    init() {
        input = Input()
        output = Output()
        
        transform()
    }
    
    func transform() {
        input.result.bind { [weak self] result in
            guard let self else { return }
            if let result {
                output.result.value = result
                setPostDateFormatted(createdAt: result.createdAt)
                callRequest(result: result)
            }
        }
    }
    
    struct ImageInfo {
        let size: String
        let views: String
        let downloads: String
    }
    
    private func setPostDateFormatted(createdAt: String) {
        DateFormatterManager.shared.getDateFormat(createdAt) { [weak self] date in
            guard let self else { return }
            output.postDateInfo = date + "게시"
        }
    }
    
    private func callRequest(result: Results) {
        NetworkManager.shared.callRequest(api: .detail(id: result.id)) { [weak self] (statistics: Statistics) in
            guard let self else { return }
            output.imageInfo.value = ImageInfo(size: "\(result.width) X \(result.height)",
                                               views: statistics.views.total.formatted(),
                                               downloads: statistics.downloads.total.formatted())
        } failureHandler: { [weak self] code, message  in
            guard let self else { return }
            output.errorMessage = message
        }
    }
}
