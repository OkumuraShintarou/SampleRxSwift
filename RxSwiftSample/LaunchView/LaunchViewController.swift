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

final class LaunchViewController: UIViewController {
    
    fileprivate let bag = DisposeBag()
    
    // fileprivateは同一ファイルのみから参照できる
    // private(set)setterのみprivate(クラス内だけ呼び出せる)
    // まとめ: 同一ファイルからのみアクセスできる且つ、vmを呼び出す時はこのクラス内からのみ呼び出せる
    fileprivate private(set) var vm = TextFieldViewModel()
    
    fileprivate var testLabelView: NameLabelView! //TestLabelViewのインスタンスを作成
    
    static func vc() -> UIViewController {
        return R.storyboard.launchViewController().instantiateInitialViewController()!
    }
    
    @IBOutlet fileprivate weak var label:     UILabel!
    @IBOutlet fileprivate weak var textField: UITextField!
    @IBOutlet fileprivate weak var button:    UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTextField()
        bindButton()
        bindFromVM()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
}

extension LaunchViewController {
    
    private func bindButton() {
        button
            .rx
            .tap
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
                wself.showAlert(value: value)
            })
            .disposed(by: bag)
    }
    
    private func showAlert(value: String) {
        let alert = UIAlertController (
            title: "あなたの名前は",
            message: value,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{
            (action: UIAlertAction!) -> Void in
            SelectColorViewController.show(from: self,value: value)
         
        })
        )
        self.present(alert, animated: true, completion: nil)
    }

}

