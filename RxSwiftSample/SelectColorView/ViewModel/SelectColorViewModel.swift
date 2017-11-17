//
//  MergeTextViewModel.swift
//  RxSwiftSample
//
//  Created by 奥村晋太郎 on 2017/11/08.
//  Copyright © 2017年 ShintarouOkumura. All rights reserved.
//

import Foundation
import RxSwift

final class SelectColorViewModel {
    fileprivate let bag = DisposeBag()
    
    let yourNameText$: Observable<String>
    
    let yourNameTextTrigger = PublishSubject<String>()
    
    var name = String()
    
    init() {
        yourNameText$ = yourNameTextTrigger
            .flatMap { t -> Observable<String> in
                return Observable.just(t)
        }
        .share(replay: 1)

    }
}
