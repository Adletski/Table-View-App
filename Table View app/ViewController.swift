//
//  ViewController.swift
//  Table View app
//
//  Created by Adlet Zhantassov on 26.03.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var dataClosure: ((Place) -> Void)?
    
    var places = [Place(name: "Burger Heroes", location: "Astana", type: "Restaurant", image: "thanos"),
                  Place(name: "Kitchen", location: "Almaty", type: "Kafe", image: "thanos"),
                  Place(name: "Bonsai", location: "Semey", type: "Office", image: "thanos"),
                  Place(name: "Dastarkhan", location: "Turan", type: "Kafe", image: "thanos"),
                  Place(name: "IndoKitai", location: "Kyzylorda", type: "Bar", image: "thanos"),
                  Place(name: "Balkan Grill", location: "Taraz", type: "Kafe", image: "thanos"),
                  Place(name: "LoveNLife", location: "Astana", type: "Restaurant", image: "thanos")]
    
//    var place
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
//    override func viewWillAppear(_ animated: Bool) {
//        tableView.reloadData()
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Snell Roundhand", size: 20)]
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        title = "Restaurants"
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func addButtonPressed() {
        let settingVC = SettingViewController()
        settingVC.dataClosure = { [weak self] place in
            print("closure")
            self?.places.append(place)
            self?.tableView.reloadData()
        }
        navigationController?.pushViewController(settingVC, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
//        cell.foodImageView.image = UIImage(named: places[indexPath.row].placeImage.!)
        cell.name.text = places[indexPath.row].name
        cell.location.text = "Location: \(places[indexPath.row].location)"
        cell.type.text = "Type: \(places[indexPath.row].type)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}



