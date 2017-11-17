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

final class SelectColorViewController: UIViewController {
    
    fileprivate let bag = DisposeBag()
    
    fileprivate var yourName = String()
    
    fileprivate private(set) var setColorView = SelectColorView()
    fileprivate private(set) var vm           = SelectColorViewModel()
    
    fileprivate var helloLabel       : NameLabelView!
    fileprivate var yourNameLabel    : NameLabelView!
    fileprivate var likeColorButtons : SelectColorView!
    
    @IBOutlet fileprivate weak var mergeView      : UIView!
    @IBOutlet fileprivate weak var mergeButtonView: UIView!
    
    static func show(from: UIViewController, value: String) {
        let vc = R.storyboard.selectColorViewController().instantiateInitialViewController()! as? SelectColorViewController
        guard let v = vc  else { return }
        v.yourName = value
        from.navigationController?.pushViewController(v, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
}

extension SelectColorViewController {
    
    private func configureUI() {
        configureView()
    }
    
    private func configureView() {
        helloLabel = NameLabelView.create(value: yourName)
        helloLabel.frame = CGRect(
            x: 0,
            y: 50,
            width: mergeView.frame.width, // mergeViewの幅に大きさを合わせる
            height: NameLabelView.height()
        )
        
        yourNameLabel = NameLabelView.create(value: yourName)
        yourNameLabel.frame = CGRect(
            x: 0,
            y: 50,
            width: mergeView.frame.width,
            height: NameLabelView.height()
        )
        
        likeColorButtons = SelectColorView.create(vm: vm) // likeColorButtonsにviewを作成
        likeColorButtons.frame = CGRect(
            x: 0,
            y: 0,
            width: mergeButtonView.frame.width,
            height: SelectColorView.height() // 高さを指定
        )
        
        yourNameLabel.configureLabel() // 名前を表示
        mergeView.addSubview(yourNameLabel)
        mergeButtonView.addSubview(likeColorButtons)
    }
    
    private func bindButtons() {
    }
    
}
