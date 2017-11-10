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
    
    fileprivate private(set) var tfVm = TextFieldViewModel()
    fileprivate private(set) var mtVm = MergeTextViewModel()
    
    fileprivate var testLabelView: TestLabelView! //TestLabelViewのインスタンスを作成
    
    static func vc() -> UIViewController {
        return R.storyboard.textFieldViewController().instantiateInitialViewController()!
    }
    
    @IBOutlet fileprivate weak var label:     UILabel!
    @IBOutlet fileprivate weak var textField: UITextField!
    @IBOutlet fileprivate weak var button:    UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTextField()
        bindButtons()
        bindFromVM()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
}

extension TextFieldViewController {
    
    private func bindButtons() {
        button
            .rx
            .tap
            .throttle(0.7, latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let wself = self else { return }
                guard let text  =  wself.label.text else { return }
                wself.tfVm.fetchedTextTrigger.onNext("\(text)")
                wself.mtVm.fetchedTextTrigger.onNext("fffff")
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
        tfVm
            .fetchedText$
            .subscribe(onNext: { [weak self] value in
                guard let wself = self else { return }
                wself.showAlert(value: value)
            })
            .disposed(by: bag)
        
        mtVm.fechedText$
            .subscribe(onNext: { [weak self] response in
                guard let wself = self else { return }
                wself.mtVm.name = response
            })
            .disposed(by: bag)
        
    }
    
    private func showAlert(value: String) {
        let alert = UIAlertController (
            title: "あなたが入力したもの",
            message: value,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{
            (action: UIAlertAction!) -> Void in
            MergeTextViewController.show(from: self)
        })
        )
        self.present(alert, animated: true, completion: nil)
    }
    
}
