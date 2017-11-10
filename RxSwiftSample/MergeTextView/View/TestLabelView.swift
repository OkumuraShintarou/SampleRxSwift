//
//  TestLabelView.swift
//  RxSwiftSample
//
//  Created by 奥村晋太郎 on 2017/11/09.
//  Copyright © 2017年 ShintarouOkumura. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class TestLabelView: UIView {
    
    fileprivate let bag = DisposeBag()
    
    fileprivate private(set) var vm = MergeTextViewModel()
    
    @IBOutlet fileprivate weak var helloLabel: UILabel!
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    
    
    static func height() -> CGFloat {
        return 20
    }
    
    // .xib自体の高さ、幅を指定
    static func create(_ vm: MergeTextViewModel) -> TestLabelView {
        let view = R.nib.labelView.firstView(owner: nil)!
        //view.frame.size.height = height()
        view.vm = vm
        view.frame.size.width = UIScreen.main.bounds.width
        return view
    }
    
    
    func configureLabel(){
        helloLabel.text = "Hello!!"
        nameLabel.text =  vm.name
        }
}

extension TestLabelView {
    func bindVM() {
        vm.fechedText$
            .subscribe(onNext: { [weak self] response in
                guard let wself = self else { return }
                wself.vm.name = response
            })
            .disposed(by: bag)
    }
}

