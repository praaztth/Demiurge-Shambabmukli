//
//  ViewController.swift
//  Demiurge Shambabmukli
//
//  Created by tryuruy on 10.09.2024.
//

import UIKit

class ViewController: UIViewController {
    struct Datasource {
        enum CellType: String {
            case alive = "alive"
            case dead = "dead"
            case life = "life"
        }
        
//        var name: String
//        var description: String
        var type: CellType
    }
    
    var datasource = [Datasource]()
    var countAliveCells = 0
    var countDeadCells = 0
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.cellName)
        view.backgroundColor = .clear
        
        return view
    }()
    
    let button: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30)
        config.baseBackgroundColor = UIColor(red: 90/255, green: 52/255, blue: 114/255, alpha: 1)
        config.baseForegroundColor = .white
        
        button.configuration = config
        button.setTitle("Сотворить", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.addSubview(collectionView)
        view.addSubview(button)
        
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize = CGSize(width: view.frame.width - 20, height: 70)
        
        title = "Клеточное наполнение"
        
        activateConstraints()
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10)
        ])
    }
    
    @objc
    func buttonPressed() {
        let isAlive = Bool.random()
        
        if isAlive {
            countAliveCells += 1
            
            if countAliveCells == 3 {
                createLifeCell()
                countAliveCells = 0
                
            } else {
                createAliveCell()
                countDeadCells = 0
            }
            
        } else {
            countDeadCells += 1
            
            if countDeadCells == 3 {
                killLifeCell()
                countDeadCells = 0
                
            } else {
                createDeadCell()
                countAliveCells = 0
            }
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func createAliveCell() {
        datasource.insert(Datasource(type: .alive), at: 0)
    }
    
    func createLifeCell() {
        datasource.removeFirst()
        datasource.removeFirst()
        datasource.insert(Datasource(type: .life), at: 0)
//        datasource.append(Datasource(type: .life))
    }
    
    func createDeadCell() {
        datasource.insert(Datasource(type: .dead), at: 0)
//        datasource.append(Datasource(type: .dead))
    }
    
    func killLifeCell() {
        datasource.removeFirst()
        datasource.removeFirst()
        
        if datasource.first?.type == .life {
            datasource.removeFirst()
            datasource.insert(Datasource(type: .dead), at: 0)
//            datasource.append(Datasource(type: .dead))
            
        } else if datasource.first?.type == .alive {
            for _ in 0..<(countAliveCells + 1) {
                datasource.removeFirst()
            }
        }
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = datasource[indexPath.item]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.cellName, for: indexPath) as? MyCollectionViewCell else {
            return UICollectionViewCell(frame: .zero)
        }
        
        switch item.type {
        case .alive:
            cell.titleLabel.text = "Живая"
            cell.subtitleLabel.text = "и шевелится!"
            cell.imageLabel.backgroundColor = .yellow
            cell.imageLabel.text = "💥"
        case .life:
            cell.titleLabel.text = "Жизнь"
            cell.subtitleLabel.text = "Ку-ку!"
            cell.imageLabel.backgroundColor = .systemPink
            cell.imageLabel.text = "🐣"
        case .dead:
            cell.titleLabel.text = "Мёртвая"
            cell.subtitleLabel.text = "или прикидывается"
            cell.imageLabel.backgroundColor = .green
            cell.imageLabel.text = "💀"
        }
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selecting item")
    }
}
