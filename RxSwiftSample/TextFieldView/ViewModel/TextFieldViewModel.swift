//
//  FirstViewModel.swift
//  RxSwiftSample
//
//  Created by 奥村晋太郎 on 2017/11/07.
//  Copyright © 2017年 ShintarouOkumura. All rights reserved.
//

import Foundation
import RxSwift


final class TextFieldViewModel {
    fileprivate let bag = DisposeBag()
    
    let fetchedText$: Observable<String>
    
    let fetchedTextTrigger = PublishSubject<String>()
    
    init() {
        fetchedText$ = fetchedTextTrigger
            .flatMap{ s -> Observable<String> in
                return Observable.just(s)
            }
            .share(replay: 1)
        }
}
