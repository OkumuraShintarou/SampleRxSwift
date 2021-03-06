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
    fileprivate var selectColorView  : SelectColorView!
    
    @IBOutlet fileprivate weak var mergeView      : UIView!
    @IBOutlet fileprivate weak var mergeButtonView: UIView!
    @IBOutlet fileprivate weak var segueButtonView: UIView!
    
    static func show(from: UIViewController, value: String) {
        let vc = R.storyboard.selectColorViewController().instantiateInitialViewController()! as? SelectColorViewController
        guard let v = vc  else { return }
        v.yourName = value
        from.navigationController?.pushViewController(v, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindButtons()
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
            width : mergeView.frame.width,
            height: NameLabelView.height()
        )
        
        selectColorView = SelectColorView.create(vm: vm) // likeColorButtonsにviewを作成
        selectColorView.frame = CGRect(
            x: 0,
            y: 0,
            width : mergeButtonView.frame.width,
            height: SelectColorView.height() // 高さを指定
        )
        
        yourNameLabel.configureLabel() // 名前を表示
        mergeView.addSubview(yourNameLabel)
        mergeButtonView.addSubview(selectColorView)
        
    }
    
    private func bindButtons() {
        
        selectColorView
            .redButtonTaps
            .subscribe(onNext: { [weak self]  in
                guard let wself = self else { return }
                wself.showAlert(value: "赤色")
        })
        .disposed(by: bag)
        
        selectColorView
            .blueButtonTaps
            .subscribe(onNext: { [weak self]  in
                guard let wself = self else { return }
                wself.showAlert(value: "青色")
                
        })
        .disposed(by: bag)
        
        selectColorView
            .yellowButtonTaps
            .subscribe(onNext: { [weak self] in
                guard let wself = self else { return }
                wself.showAlert(value: "黄色")
        })
        .disposed(by: bag)
        
        selectColorView
            .greenButtonTaps
            .subscribe(onNext: { [weak self] in
                guard let wself = self else { return }
                wself.showAlert(value: "緑色")
        })
        .disposed(by: bag)
        
    }
    
    private func showAlert(value: String) {
        let alert = UIAlertController (
            title: "あなたの好きな色は",
            message: value,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "最初の画面へ", style: .default, handler: {
            (action: UIAlertAction!) -> Void in
            LaunchViewController.show(from: self)
        })
        )
        self.present(alert, animated: true, completion: nil)
    }
    
}
