//
//  ExploreViewController.swift
//  JamzApp
//
//  Created by Adrianna Parlato on 10/11/22.
//
import SafariServices
import UIKit

class ExploreViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {

  
    let searchController: UISearchController = {
        let results = UIViewController()
        
        let vc = UISearchController(searchResultsController: SearchResultsViewController())
       //must add user profile too
        vc.searchBar.placeholder = "Songs, Artists, Albums"
        vc.searchBar.searchBarStyle = .minimal
        vc.definesPresentationContext = true
        
        return vc
    }()

    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 7, bottom: 2, trailing: 7)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150)),
                                                           subitem: item,
                                                        count: 2)
            group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
            return NSCollectionLayoutSection(group: group)
        }))
    private var categories = [Category]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        view.addSubview(collectionView)
        collectionView.register(CategoryCollectionViewCell.self,
                                forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        
        
        
        APICaller.shared.getCategories { [weak self] result in
            DispatchQueue.main.async {
            switch result {
            case .success(let categories):
                self?.categories = categories
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
            }
        }
    
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let resultsController = searchController.searchResultsController as? SearchResultsViewController,
               let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        resultsController.delegate = self
        
        
        //only call search api when use click search button
        APICaller.shared.search(with: query) { result in
            DispatchQueue.main.async {
            switch result {
            case .success(let results):
                resultsController.update(with: results)
            case .failure(let error):
                print(error.localizedDescription)
                }
            }
        }
    }
    
    //records every button pressed in search barr
    func updateSearchResults(for searchController: UISearchController) {
    }
}

extension ExploreViewController: SearchResultsViewControllerDelegate {
    func didTapResults(_ result: SearchResult) {
        switch result {
        case .artists(let model):
            guard let url = URL(string: model.external_urls["spotify"] ?? "") else {
                return
            }
            //when user clicks on artits this built in safari will allow the to go to spotiy's sarafi page for that unique artist
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
            //cell.textLabel?.text = model.name
        case .album(let model):
           let vc = AlbumViewController(album: model)
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
            
            
        case .track(let model):
            //anytime user clicks on any 'song' row on amy page of the app a presenter page will appear
            PlaybackPresenter.shared.startPlayback(from: self, track: model)
          
        case .playlist(let model):
            let vc = PlaylistViewController(playlist: model)
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
            
    }
    }
}

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categories.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCollectionViewCell.identifier,
            for: indexPath)
                as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        let category = categories[indexPath.row]
        cell.configure(with: CategoryCollectionViewCellViewModel(
            title: category.name,
            artworkURL: URL(string: category.icons.first?.url ?? "" )))
        //cell.backgroundColor = .systemGreen
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        HapticsManager.shared.vibrateForSelection()
        let category = categories[indexPath.row]
        let vc = CategoryViewController(category: category)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
}

