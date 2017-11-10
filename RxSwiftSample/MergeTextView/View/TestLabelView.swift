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
    
    @IBOutlet fileprivate weak var mergeLabel: UILabel!
    
    static func height() -> CGFloat {
        return 120
    }
    
    // .xib自体の高さ、幅を指定
    static func create() -> TestLabelView {
        let view = R.nib.labelView.firstView(owner: nil)! // nib.labelViewというのは.xibファイルのこと。.xibファイルのViewを作成している
        view.frame.size.height = height() // .xibの高さを指定。addSubviewした時の高さ？？
        view.frame.size.width = UIScreen.main.bounds.width // labelの幅は、画面サイズの幅に合わせるよ。デバイスの幅サイズを取得している
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib() // Viewが作られた後に呼ばれる
        configureLabel()
    }
    
    func configureLabel(){
        mergeLabel.text = "コンバンワ"
    }
}
