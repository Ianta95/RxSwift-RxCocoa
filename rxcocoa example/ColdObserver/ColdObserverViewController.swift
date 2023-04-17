//
//  ColdObserverViewController.swift
//  rxcocoa example
//
//  Created by Ian Barragan Preciado on 14/04/23.
//

import UIKit
import RxSwift

class ColdObserverViewController: UIViewController {
    
    let disposeBag: DisposeBag = DisposeBag()
    var coldObservable: Observable<String>? = nil
    lazy var btnSubscribe: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Suscribirse", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        prepareUI()
        self.view.backgroundColor = .white
        coldObservable = mockColdObservable(element: "Este es un obvserbable de tipo cold")
    }
    
    func mockColdObservable(element: String) -> Observable<String> {
        return Observable.create { observer in
            observer.on(.next(element))
            observer.on(.completed)
            return Disposables.create()
        }
    }
    
    private func prepareUI(){
        self.view.addSubview(btnSubscribe)
        btnSubscribe.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        btnSubscribe.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    @objc func clickButton(){
        coldObservable?.subscribe(onNext: { element in
            print("element")
        }).disposed(by: disposeBag)
    }
    
}

