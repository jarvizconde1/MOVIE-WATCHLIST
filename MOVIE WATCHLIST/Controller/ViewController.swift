//
//  ViewController.swift
//  MOVIE WATCHLIST
//
//  Created by Jarvis Vizconde on 9/4/23.
//

import UIKit

class ViewController: UIViewController , DetailsViewControllerDelegate{
    
  
    
    
  
    @IBOutlet weak var MoviesTableView: UITableView!
    
    
    var moviesArray = MoviesDatabase()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        MoviesTableView.dataSource = self
        MoviesTableView.delegate = self
        
      
        MoviesTableView.register(UINib(nibName: "MoviesCollection" , bundle: nil ), forCellReuseIdentifier: MoviesCollection.identifier)
        
        self.MoviesTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear!")
    }
    
    
    
    @IBAction func sortButton(_ sender: Any) {
        
        
        let alert = UIAlertController(title: "Sort By", message: nil , preferredStyle: UIAlertController.Style.actionSheet)

        
        
        let titleAction = UIAlertAction(title: "Title", style: UIAlertAction.Style.default) { action in
            
            let sortedMovies = self.moviesArray.movieChoices.sorted(by: { (p1, p2) -> Bool in
                return p1.title < p2.title
                
            })
            
            self.moviesArray.movieChoices = sortedMovies
            self.MoviesTableView.reloadData()
            
            
        }
        
        let releaseDateAction = UIAlertAction(title: "Release Date", style: UIAlertAction.Style.default) { action in
        
           
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM YYYY"

        
            let sortedMovies = self.moviesArray.movieChoices.sorted { (movie1, movie2) -> Bool in
                let date1 = dateFormatter.date(from: movie1.releaseDate)!
                let date2 = dateFormatter.date(from: movie2.releaseDate)!
                return date1 < date2
            }
            
            
            self.moviesArray.movieChoices = sortedMovies
            self.MoviesTableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)

     //register your newly created action
        alert.addAction(titleAction)
        alert.addAction(releaseDateAction)
        alert.addAction(cancelAction)

        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    func didUpdateWatchlist( movies updatedMovies: Movies) {
        
        // Find the index of the element with the same title
        guard let index = moviesArray.movieChoices.firstIndex(where: { $0.title == updatedMovies.title }) else {
          // The element the same title does not exist in the array.
          return
        }
        

        // Update the watchlist status of the element at the index.
        moviesArray.movieChoices[index].watchlist = updatedMovies.watchlist
        
        
        MoviesTableView.reloadData()
    }

    

}

//MARK: - using a delegate to update the movie database after it is updated to detailsViewController

protocol DetailsViewControllerDelegate {
    
    func didUpdateWatchlist(movies: Movies)
    
}


//MARK: - TABLEVIEW

extension ViewController : UITableViewDataSource ,UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.movieChoices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = MoviesTableView.dequeueReusableCell(withIdentifier: "moviesCell" , for: indexPath) as! MoviesCollection
        cell.setup(movie: moviesArray.movieChoices[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let pressedMovie = self.moviesArray.movieChoices[indexPath.row]
        
        performSegue(withIdentifier: "goToDetails", sender: pressedMovie )
        
    }
    
    
    
    
    //MARK: -  PREPARING FOR SEGUE WHEN A MOVIE IS PRESSED - IT WILL GO TO DETAILS VIEW
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        guard let selectedMovie = sender as? Movies else {
            return
        }
        
        if segue.identifier == "goToDetails"{
            
            guard let destinatonVC = segue.destination as? DetailsViewController else {
                return
            }
            
            
            destinatonVC.delegate = self
            destinatonVC.selectedMovies = selectedMovie
            
            
            
        }
        
      
        
        
    }
    
  
    
    
}
    


