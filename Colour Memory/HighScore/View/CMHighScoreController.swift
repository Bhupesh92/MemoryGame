//
//  CMHighScoreController.swift
//  Colour Memory
//
//  Created by Bhupesh on 19/05/22.
//  Copyright © 2022 Acd. All rights reserved.
//

import UIKit

class CMHighScoreController: UIViewController {
    
    var presenter: CMHighScoreViewToPresenterProtocol?

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialSetup()
        self.view.showActivityIndicator()
        self.presenter?.fetchUsers()
    }
    override func viewWillDisappear(_ animated: Bool) {
        CMOrientationManager.landscapeSupported = false
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: Register Nib
    private func initialSetup() {
        tableView.register(UINib(nibName: CMConstant.Identifier.cmScoreCell, bundle: nil), forCellReuseIdentifier: CMConstant.Identifier.cmScoreCell)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

}

// MARK: UITableView Datasource
extension CMHighScoreController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CMConstant.Identifier.cmScoreCell, for: indexPath)
        if let user = self.presenter?.users?[indexPath.row] {
            (cell as? CMHighScoreCell)?.updateCell(user: user, rank: indexPath.row + 1)
        }
        return cell
    }
    
}

// MARK: UITableView Delegate
extension CMHighScoreController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return CMConstant.estimatedCellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

// MARK: - CMHighScorePresenterToViewProtocol
extension CMHighScoreController: CMHighScorePresenterToViewProtocol {
    
    func fetchedUsers(error: String) {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else {
                return
            }
            self.view.hideActivityIndicator()
            if !error.isEmpty {
                CMAlert(title: error, message: "", textFieldNeed: false).showAlert(base: self) { _ in
                    self.navigationController?.popToRootViewController(animated: true)
                }
               return
            }
            self.tableView.reloadData()
        }

    }
}
