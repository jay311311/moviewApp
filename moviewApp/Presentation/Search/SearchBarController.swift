//
//  SearchBarController.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/12/06.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

class SearchBarController: UISearchController, UISearchBarDelegate, View {
    var disposeBag =  DisposeBag()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.reactor = SearchViewModel()
    }
    
    
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(reactor: SearchViewModel) {
        searchBar.rx.text
            .distinctUntilChanged()
            .map{ Reactor.Action.tapReturn($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        searchBar.rx.cancelButtonClicked
            .map { Reactor.Action.tapCancel}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map{  $0.text }
            .subscribe(onNext:{
                self.searchBar.text = $0
            })
    }
    
   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
