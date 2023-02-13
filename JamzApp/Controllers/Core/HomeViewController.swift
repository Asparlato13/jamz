//
//  ViewController.swift
//  JamzApp
//
//  Created by Adrianna Parlato on 10/11/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var postTextField: UITextField!
       
       var selectedSong: Song?

       @IBAction func submitButtonTapped(_ sender: Any) {
           guard let postText = postTextField.text, !postText.isEmpty else {
               showAlert(withTitle: "Error", message: "Please enter a post before submitting.")
               return
           }
           
           // Store the post in a database
           let post = Post(text: postText, song: selectedSong)
           storePost(post) { [weak self] result in
               switch result {
               case .success:
                   self?.postTextField.text = ""
                   self?.selectedSong = nil
                   self?.showAlert(withTitle: "Success", message: "Post was successfully stored.")
               case .failure(let error):
                   self?.showAlert(withTitle: "Error", message: error.localizedDescription)
               }
           }
       }
       
       @IBAction func searchForSong(_ sender: Any) {
           // Show a search interface for searching for songs on Spotify
           // Once a user selects a song, set the selectedSong property to the selected song
       }

       private func storePost(_ post: Post, completion: @escaping (Result<Void, Error>) -> Void) {
           // Store the post in a database, for example using Firebase
           // In case of success, call completion(.success)
           // In case of failure, call completion(.failure(error))
       }
       
       private func showAlert(withTitle title: String, message: String) {
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
       }
   }

   struct Post {
       let text: String
       let song: Song?
   }

   struct Song {
       let title: String
       let artist: String
       let album: String
   }
