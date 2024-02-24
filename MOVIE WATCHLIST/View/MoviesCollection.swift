

import UIKit
import Foundation


class MoviesCollection: UITableViewCell {
    
    static let identifier = "moviesCell"
    
    
   
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var durationAndGenre: UILabel!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var watchlist: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
    //MARK: -  SET UP
    
    func setup( movie : Movies) {
        
        
        //MARK: - <#Section Header#>
       //converts and takes only the year
        let dateString = movie.releaseDate

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"

        let date = dateFormatter.date(from: dateString)!

        let dateComponents = Calendar.current.dateComponents([.year], from: date)

        let year = dateComponents.year!

      

        
        

    
        
        title.text = ( movie.title + " " + "(" + "\(year)" + ")"  )
        durationAndGenre.text = (movie.duration + " - " + movie.genre )
        poster.image = UIImage(named: movie.title)
       
        if movie.watchlist == true {
            
            watchlist.text = "On my watchlist"
            watchlist.textColor = UIColor.darkGray
          
        }
        else{
            watchlist.text = ""
        }
        
        
    }
    
    
    
    
    
    
    
}
