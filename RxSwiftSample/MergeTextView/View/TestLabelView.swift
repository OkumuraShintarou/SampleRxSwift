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
        return 20
    }
    
    // .xib自体の高さ、幅を指定
    static func create() -> TestLabelView {
        let view = R.nib.labelView.firstView(owner: nil)!
        view.frame.size.height = height()
        view.frame.size.width = UIScreen.main.bounds.width
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLabel()
    }
    
    func configureLabel(){
        mergeLabel.text = "コンバンワ"
    }
}