//
//  ViewController.swift
//  MovieCondor
//
//  Created by leonard Borrego on 1/06/22.
//

import UIKit

class ViewController: UIViewController {

    private var presenter: HomePresenter = HomePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presenter.getMovieList()
    }

}

