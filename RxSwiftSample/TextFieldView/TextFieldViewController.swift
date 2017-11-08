//
//  ViewController.swift
//  RxSwiftSample
//
//  Created by 奥村晋太郎 on 2017/11/07.
//  Copyright © 2017年 ShintarouOkumura. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class TextFieldViewController: UIViewController {
    
    fileprivate let bag = DisposeBag()
    
    fileprivate private(set) var vm = TextFieldViewModel()
    
    static func vc() -> UIViewController {
        return R.storyboard.textFieldViewController().instantiateInitialViewController()!
    }
    
    @IBOutlet fileprivate weak var label:     UILabel!
    @IBOutlet fileprivate weak var textField: UITextField!
    @IBOutlet fileprivate weak var button:    UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTextField()
        bindFromVM()
        bindButtons()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
}

extension TextFieldViewController {
    
    private func bindButtons() {
        
        button
        .rx.tap
        .throttle(0.7, latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let wself = self else { return }
                guard let text  =  wself.label.text else { return }
                wself.vm.fetchedTextTrigger.onNext("\(text)")

            })
            .disposed(by: bag)
    }
    
    private func bindTextField() {
        textField
            .rx
            .text
            .asObservable() // textFieldのtextをObservableのStringに変換
            .bind(to: label.rx.text) // bind(to:)でUI部品のプロパティをバインド(textとtextをバインド)バインドする事でlabelに反映される
            .disposed(by: bag)
    }
    
    private func bindFromVM() {
        
        vm
            .fetchedText$
            .subscribe(onNext: { [weak self] value in
                guard let wself = self else { return }
            })
            .disposed(by: bag)
    }
}
