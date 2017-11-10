//
//  MergeTextViewController.swift
//  RxSwiftSample
//
//  Created by 奥村晋太郎 on 2017/11/08.
//  Copyright © 2017年 ShintarouOkumura. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class MergeTextViewController: UIViewController {
    
    fileprivate let bag = DisposeBag()
    
    fileprivate var testLabelView: TestLabelView!
    
    @IBOutlet fileprivate weak var mergeView: UIView!
    
    static func show(from: UIViewController) {
        let vc = R.storyboard.mergeTextViewController().instantiateInitialViewController()!
        from.navigationController?.pushViewController(vc, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
}

extension MergeTextViewController {
    private func configureUI() {
        configureView()
        
    }
    
    private func configureView() {
        testLabelView = TestLabelView.create() //testLabelViewにViewを作成
        testLabelView.frame = CGRect(
            x: 0,
            y: 50,
            width: mergeView.frame.width,
            height: TestLabelView.height() //ここようわからん
            // x: 0, y: 50の所に幅はmerfgeViewに合わせ、高さはheight()の所にカスタムビューを置くよ
        )
        mergeView.addSubview(testLabelView)
    }
    
}
