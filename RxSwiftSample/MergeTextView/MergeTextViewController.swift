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
    
    fileprivate private(set) var vm = MergeTextViewModel()
    
    fileprivate let bag = DisposeBag()
    
    fileprivate var helloLabel: TestLabelView!
    fileprivate var nameLabel: TestLabelView!
    
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
        helloLabel = TestLabelView.create()
        helloLabel.frame = CGRect(
            x: 0,
            y: 50,
            width: mergeView.frame.width, // mergeViewの幅に大きさを合わせる
            height: TestLabelView.height()
        )
        mergeView.addSubview(helloLabel)
        
        nameLabel = TestLabelView.create()
        nameLabel.frame = CGRect(
            x: 0,
            y: 50,
            width: mergeView.frame.width,
            height: TestLabelView.height()
        )
        mergeView.addSubview(nameLabel)
    }
    
    
}
