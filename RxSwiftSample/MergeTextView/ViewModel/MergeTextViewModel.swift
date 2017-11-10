//
//  MergeTextViewModel.swift
//  RxSwiftSample
//
//  Created by 奥村晋太郎 on 2017/11/08.
//  Copyright © 2017年 ShintarouOkumura. All rights reserved.
//

import Foundation
import RxSwift

final class MergeTextViewModel {
    fileprivate let bag = DisposeBag()
    
    let fechedText$: Observable<String>
    
    let fetchedTextTrigger = PublishSubject<String>()
    
    var name = String()
    
    init() {
        
        fechedText$ = fetchedTextTrigger
            .flatMap { t -> Observable<String> in
                return Observable.just(t)
        }
        .share(replay: 1)
    
    }

    
    
}
