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
    
    var text = String()
    
    static func show(from: UIViewController) {
        let vc = R.storyboard.mergeTextViewController().instantiateInitialViewController()!
        from.navigationController?.pushViewController(vc, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
