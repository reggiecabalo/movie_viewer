//
//  ViewController.swift
//  Movie Viewer
//
//  Created by Reggie Manuel Cabalo on 14/03/2018.
//  Copyright © 2018 Reggie Manuel Cabalo. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieAdvisoryRating: UILabel!
    @IBOutlet weak var movieDuration: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieSynopsis: UILabel!
    @IBOutlet weak var image_poster: UIImageView!
    @IBOutlet weak var image_poster_landscape: UIImageView!
    @IBOutlet weak var movieCast: UILabel!
    
    var theaterName: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "http://ec2-52-76-75-52.ap-southeast-1.compute.amazonaws.com/movie.json"
        Alamofire.request(url).responseObject{ (response: DataResponse<Movie>) in
            
            let movieResult = response.result.value
            self.movieName.text =  movieResult?.canonical_title!
            self.movieGenre.text = movieResult?.genre!
            self.movieAdvisoryRating.text = movieResult?.advisory_rating!
            let runtime = Double((movieResult?.runtime_mins!)!)
            let convertedHours = self.minutesToHoursMinutes(minutes: Int(runtime!))
            
            if convertedHours.leftMinutes == 0 {
                self.movieDuration.text = "\(convertedHours.hours)hr"
            } else {
                self.movieDuration.text = "\(convertedHours.hours)hr \(convertedHours.leftMinutes) mins"
            }
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd"
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "MMM dd, yyyy"
            
            let date: Date? = dateFormatterGet.date(from: (movieResult?.release_date)!)
            
            self.movieReleaseDate.text = "\(dateFormatterPrint.string(from: date!))"
            self.movieSynopsis.text =  movieResult?.synopsis!
            
            let url = URL(string: (movieResult?.poster!)!)
            let url_poster_landscape = URL(string: (movieResult?.poster_landscape!)!)
            
            let stringCast = movieResult?.cast?.joined(separator: ", ")
            
            self.movieCast.text = stringCast
            
            self.theaterName = movieResult?.theater!
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                let data_landscape = try? Data(contentsOf: url_poster_landscape!)
                DispatchQueue.main.async {
                    if data_landscape == nil {
                        self.image_poster_landscape.image = nil
                    } else {
                        self.image_poster_landscape.image = UIImage(data: data_landscape!)
                    }
                    
                    if data == nil {
                        self.image_poster.image = nil
                    } else {
                        self.image_poster.image = UIImage(data: data!)
                    }
                    
                    
                }
            }
        }
    }
    

    @IBAction func goToSeatMap(_ sender: Any) {
        
        let seatMapVC = self.storyboard?.instantiateViewController(withIdentifier: "SeatMapViewController") as! SeatMapViewController
        seatMapVC.theaterDataString = self.theaterName
        self.navigationController?.pushViewController(seatMapVC, animated: true)
        
    }
    
    func minutesToHoursMinutes (minutes : Int) -> (hours : Int , leftMinutes : Int) {
        return (minutes / 60, (minutes % 60))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

