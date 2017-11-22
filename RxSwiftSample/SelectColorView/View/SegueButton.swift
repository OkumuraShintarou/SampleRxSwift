//
//  SegueButton.swift
//  RxSwiftSample
//
//  Created by 奥村晋太郎 on 2017/11/22.
//  Copyright © 2017年 ShintarouOkumura. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SegueButton: UIView {
    let segueButtontaps = PublishSubject<Void>()
    
    fileprivate let bag = DisposeBag()
    
    fileprivate private(set) weak var vm: SelectColorViewModel! {
        didSet {
            configure()
        }
    }
    
    @IBOutlet fileprivate weak var segue: UIButton!
    
    static func height() -> CGFloat {
        return 78
    }
    
    static func create(vm: SelectColorViewModel) -> SegueButton {
        let view = R.nib.segueButton.firstView(owner: nil)!
        view.vm = vm
        view.frame.size.height = height() //親ビューはカスタムビュー
        view.frame.size.width  = UIScreen.main.bounds.width
        return view
    }
    
}

fileprivate extension SegueButton {
    
    func configure() {
        guard vm != nil else { return }
        bindButtons()
    }
    
    func bindButtons() {
        segue.rx
            .tap
            .throttle(0.7, latest: false, scheduler: MainScheduler.instance)
            .bind(to: segueButtontaps)
            .disposed(by: bag)
    }
    
}
