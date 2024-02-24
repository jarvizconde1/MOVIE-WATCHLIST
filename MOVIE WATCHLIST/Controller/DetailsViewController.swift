//
//  DetailsViewController.swift
//  MOVIE WATCHLIST
//
//  Created by Jarvis Vizconde on 9/15/23.
//

import UIKit

class DetailsViewController: UIViewController {
    
    
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var shortDescription: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var releaseDate: UILabel!    
    @IBOutlet weak var watchlistButton: UIButton!
    
    
    var selectedMovies : Movies?
    
     var delegate: DetailsViewControllerDelegate?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
        poster.image = UIImage(named: selectedMovies?.title ?? "none")
        movieTitle.text = selectedMovies?.title
        rating.text = (selectedMovies?.rating)
        shortDescription.text = selectedMovies?.description
        genre.text = selectedMovies?.genre
        releaseDate.text = selectedMovies?.releaseDate
        
        updateButtonWatchList()
        

    }
    
    
    //MARK: -  checks the watchlist and updates the button based on status
    func updateButtonWatchList() {
        
        if selectedMovies?.watchlist == true {
            
            watchlistButton.setTitle("REMOVE", for: .normal)
            
        } else {
            watchlistButton.setTitle("ADD", for: .normal)
        }
    }
    
    

    

    

    @IBAction func addToWatchList(_ sender: Any) {
        if let watchList = selectedMovies?.watchlist{
            
            self.selectedMovies!.watchlist = !watchList
          
            updateButtonWatchList()
            
            delegate?.didUpdateWatchlist(movies: selectedMovies!)
            
        }
        else {
            print("error")
        }
        
    }
    
    @IBAction func watchTrailer(_ sender: Any) {
        UIApplication.shared.open(URL(string : selectedMovies?.trailerLink ?? "youtube.com")! as URL, options: [:], completionHandler: nil)
    }
    
    
    @IBAction func donePressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
   
    
    
    
    
    
    
  
    
}
