//
//  SelectColorView.swift
//  RxSwiftSample
//
//  Created by 奥村晋太郎 on 2017/11/12.
//  Copyright © 2017年 ShintarouOkumura. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// .xibのクラス
final class SelectColorView: UIView {
    let redButtonTaps    = PublishSubject<Void>()
    let blueButtonTaps   = PublishSubject<Void>()
    let yellowButtonTaps = PublishSubject<Void>()
    let greenButtonTaps  = PublishSubject<Void>()
    
    fileprivate let bag = DisposeBag()
    
    fileprivate private(set) weak var vm: SelectColorViewModel! {
        didSet {
            configure() // vmプロパティの変更後にsetされる
        }
    }
    
    @IBOutlet fileprivate weak var redButton: UIButton!
    @IBOutlet fileprivate weak var blueButton: UIButton!
    @IBOutlet fileprivate weak var yellowButton: UIButton!
    @IBOutlet fileprivate weak var greenButton: UIButton!
    
    static func height() -> CGFloat {
        return 370  // カスタムビュー自体の高さ
    }
    
    static func create(vm: SelectColorViewModel) -> SelectColorView {
        let view = R.nib.selectColorView.firstView(owner: nil)!
        // ここでSelectColorViewが参照され、カスタムビューのインスタンスが作成される。
        view.vm = vm // vmのプロパティの値が変更されたのでconfigure()がセットされる
        view.frame.size.height = height() // view(SelectColorViewの高さ)
        view.frame.size.width  = UIScreen.main.bounds.width // view(SelectColorViewの幅)
        return view
    }
}
    
fileprivate extension SelectColorView {
    
    // vmのプロパティが変更された時
    func configure() {
        guard vm != nil else { return } // vmがnilでなければ
        bindButtons()
    }
    
    func bindButtons() {
        // バインドされた時にVCでsubscribeしておいて、挙動を記述する
        // configureで呼ぶことによって、createされたタイミングでボタンの挙動を記述できる
        // ボタンをタップするとredbuttontapsにバインドされるという挙動をvmを作成した時にかく
        
        redButton.rx
            .tap
            .throttle(0.7, latest: false, scheduler: MainScheduler.instance)
            .bind(to: redButtonTaps)
            .disposed(by: bag)
        
        blueButton.rx
            .tap
            .throttle(0.7, latest: false, scheduler: MainScheduler.instance)
            .bind(to: blueButtonTaps)
            .disposed(by: bag)
        
        yellowButton.rx
            .tap
            .throttle(0.7, latest: false, scheduler: MainScheduler.instance)
            .bind(to: yellowButtonTaps)
            .disposed(by: bag)
        
        greenButton.rx
            .tap
            .throttle(0.7, latest: false, scheduler: MainScheduler.instance)
            .bind(to: greenButtonTaps)
            .disposed(by: bag)
        }
    
}

