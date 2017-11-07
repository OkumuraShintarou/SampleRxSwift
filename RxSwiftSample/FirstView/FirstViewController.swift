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

final class FirstViewController: UIViewController {
    
    fileprivate let bag = DisposeBag()
    
    @IBOutlet fileprivate weak var label: UILabel!
    @IBOutlet fileprivate weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTextField()
    }

}

extension FirstViewController {
    func bindTextField() {
        textField
            .rx
            .text
            .asObservable() // textFieldのtextをObservableのStringに変換
            .bind(to: label.rx.text) // bind(to:)でUI部品のプロパティをバインド(textとtextをバインド)バインドする事でlabelに反映される
            .disposed(by: bag)
    }
}
