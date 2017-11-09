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
        return 21
    }
    
    static func create() -> TestLabelView {
        let view = R.nib.labelView.firstView(owner: nil)! // nib.labelViewというのは.xibファイルのこと。.xibファイルのViewを作成している
        view.frame.size.height = height() // そのViewの高さを指定
        view.frame.size.width = UIScreen.main.bounds.width // viewの幅. addSubViewする幅に合わせてくれる
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib() // Viewが作られた後に呼ばれる
    }
    
    func configureLabel(value: String) {
        mergeLabel.text = value
    }
}
