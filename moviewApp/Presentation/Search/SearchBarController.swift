//
//  SearchBarController.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/12/06.
//

import UIKit

class SearchBarController: UISearchController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: nil)
        self.searchBar.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("작성 시오시작")
//        self.searchBar.becomeFirstResponder()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("작성 끄으으읏")

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
