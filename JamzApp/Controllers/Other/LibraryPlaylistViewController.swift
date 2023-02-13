//
//  LibraryPlaylistViewController.swift
//  JamzApp
//
//  Created by Adrianna Parlato on 2/13/23.
//


import UIKit

class LibraryPlaylistViewController: UIViewController, UITableViewDataSource {

    
    var playlists = [Playlist]()
    
    //return to user a selected playlist
    public var selectionHandler: ((Playlist) -> Void)?
    
    private let noPlaylistsView = ActionLabelView()
    
    //create table vuew
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SearchResultSubtitleTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifier)
        tableView.isHidden = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(noPlaylistsView)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        setUpNoPlaylistsView()
       //  fetchData()
        
        // if the user is selcting to add playlsit and then wants to cancel
        if selectionHandler != nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        }
            
    }
//selecor to dismiss adding to playlist
    @objc func didTapClose(){
        dismiss(animated: true, completion: nil)
    }
    
    
    private func setUpNoPlaylistsView() {
        view.addSubview(noPlaylistsView)
        noPlaylistsView.delegate = self
        //if user doesn't have playlists
        noPlaylistsView.configure(with: ActionLabelViewViewModel(text: "You don't have any playlists yet", actionTitle: "Create"))
    }
    
    
//    private func fetchData() {
//        //call api
//        APICaller.shared.getCurrentUserPlaylists { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let playlists):
//                    self?.playlists = playlists
//                    self?.updateUI()
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//
//            }
//
//
//        }
//    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noPlaylistsView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        noPlaylistsView.center = view.center
        tableView.frame = view.bounds
    }
    private func updateUI() {
        if playlists.isEmpty {
            //show label-- create new playlist
            noPlaylistsView.isHidden = false
            tableView.isHidden = true
        }
        else {
            //show tabel
            tableView.reloadData()
            tableView.isHidden = false
            noPlaylistsView.isHidden = true
        }
        
    
    }
    
    public func showCreatePlaylistAlert() {
        let alert = UIAlertController(
            title: "New Playlists",
            message: "Enter playlist name",
            preferredStyle: .alert)
    
        alert.addTextField { textField in
        textField.placeholder = "Playlists..."
        
    }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { _ in
            guard let field = alert.textFields?.first,
                  let text = field.text,
                  //trim extra whie spaces if user enters too many
                  !text.trimmingCharacters(in: .whitespaces).isEmpty else {
                return
            }
            APICaller.shared.createPlaylists(with: text) { [weak self] success in
                if success {
                    HapticsManager.shared.vibrate(for: .success)
                    //refreh list of playlist
                }
                else {
                    HapticsManager.shared.vibrate(for: .error)
                    print("Failed to create playlist")
                }
            }
        }))
    present(alert, animated: true)
    }
    
}


extension LibraryPlaylistViewController: ActionLabelViewDelegate {
    func actionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        //show creation Ui for playlist
        //single text field to enter name of newly created playlist
        showCreatePlaylistAlert()
      
}
}

extension LibraryPlaylistViewController:  UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleTableViewCell.identifier, for: indexPath) as? SearchResultSubtitleTableViewCell else {
            return UITableViewCell()
        }
        //playlsit at given postion
        let playlist = playlists[indexPath.row]
        cell.configure(with: SearchResultSubtitleTableViewCellViewModel(title: playlist.name, subtitle: playlist.owner.display_name, imageURL: URL(string: playlist.images.first?.url ?? "")))
                       return cell
    }
    
    //when user clicks playlist display data within that playlist
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        HapticsManager.shared.vibrateForSelection()
        //playlsit that user selects
        let playlist = playlists[indexPath.row]
        guard selectionHandler == nil else {
            //if it is not nill pass playlist into cell
            selectionHandler?(playlist)
            dismiss(animated: true, completion: nil)
            return
        }
        
        
        let vc = PlaylistViewController(playlist: playlist)
        vc.navigationItem.largeTitleDisplayMode = .never
        //set is owner to true so that the user can delete their own tracks from their playlist
        vc.isOwner = true
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    
    //size of playlist cell on library
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
