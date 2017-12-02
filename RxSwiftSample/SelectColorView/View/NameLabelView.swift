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

final class NameLabelView: UIView {
    
    fileprivate let bag = DisposeBag()
    
    fileprivate private(set) var vm = SelectColorViewModel() // 先にインスタンスを作成しておく
    
    @IBOutlet fileprivate weak var helloLabel: UILabel!
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    
    
    static func height() -> CGFloat {
        return 119
    }
    
    // .xib自体の高さ、幅を指定
    static func create(value: String) -> NameLabelView {
        let view = R.nib.labelView.firstView(owner: nil)! // ここでLabelView.xibがviewに格納される。このlabelviewと紐づいているのはNameLabelViewクラスだから,viewが生成されるタイミングでNameLabelViewクラスのプロパティが参照できる。ここでvmのインスタンスが作成される
        view.vm.name = value 
        view.frame.size.height = height()
        view.frame.size.width = UIScreen.main.bounds.width
        return view
    }
    
    func configureLabel() {
        helloLabel.text = "Hello!!"
        nameLabel.text =  vm.name
        }
    
}


