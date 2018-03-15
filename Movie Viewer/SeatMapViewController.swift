//
//  SeatMapViewController.swift
//  Movie Viewer
//
//  Created by Reggie Manuel Cabalo on 15/03/2018.
//  Copyright © 2018 Reggie Manuel Cabalo. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class SeatMapViewController: UIViewController {
    
    var theaterDataString: String!
    var arrayNumberOfSeats: [AnyObject]!
    @IBOutlet weak var seatCollectionView: UICollectionView!
    @IBOutlet weak var theaterData: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var buttonCinema: UIButton!
    
    @IBOutlet weak var buttonTimes: UIButton!
    @IBOutlet weak var buttonDates: UIButton!
    var x = 0
    var dates: [Dates]?
    var cinemas: [CinemasDetails]?
    var times: [TimesDetails]?
    var price: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayNumberOfSeats = []
        let url = "http://ec2-52-76-75-52.ap-southeast-1.compute.amazonaws.com/schedule.json"
        Alamofire.request(url).responseObject{ (response: DataResponse<Schedule>) in
            let scheduleResult = response.result.value
            
            self.dates = scheduleResult?.dates!
            self.cinemas = scheduleResult?.cinemas?[0].cinemas
            self.times =  scheduleResult?.times?[0].times
            
            self.buttonDates.setTitle("\(scheduleResult?.dates?[0].label ?? "")", for: .normal)
            self.buttonCinema.setTitle("\(scheduleResult?.cinemas?[0].cinemas?[0].label ?? "")", for: .normal)
            self.buttonTimes.setTitle("\(scheduleResult?.times?[0].times?[0].label ?? "")", for: .normal)
            
        }
        
        self.theaterData.text =  theaterDataString
        
        let url_seatMap = "http://ec2-52-76-75-52.ap-southeast-1.compute.amazonaws.com/seatmap.json"
        
        Alamofire.request(url_seatMap).responseObject{ (response: DataResponse<SeatMap>) in
            let seatMap = response.result.value
//            print(seatMap?.seatmap?.count)
            
            for var x in 0..<(seatMap?.seatmap?.count)!{
                var line = ""
                for var y in 0..<(seatMap?.seatmap?[x].count)! {
                    
                    print("\(x), \(y)")
                   
                    self.arrayNumberOfSeats.append((seatMap?.seatmap?[x][y])! as AnyObject)
                }
//                print(line)
            }
            
            print("total: \(self.arrayNumberOfSeats.count)")
            self.seatCollectionView.reloadData()
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func scheduleAction(_ sender: Any) {
        self.datesOption()
//        print(self.dates?.count ?? 0)
    }
    @IBAction func cinemaAction(_ sender: Any) {
        self.cinemaOption()
//        print(self.cinemas?.count ?? 0)
    }
    @IBAction func timeAction(_ sender: Any) {
        self.timesOption()
//        print(self.times?.count ?? 0)
    }
    
    func datesOption () {
        let actionSheetController = UIAlertController (title: "Choose Dates", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        for (index, date) in (self.dates?.enumerated())! {
            actionSheetController.addAction(UIAlertAction(title: date.label, style: .default, handler:{
                action in
                self.buttonDates.setTitle(date.label, for: .normal)
                
                let url = "http://ec2-52-76-75-52.ap-southeast-1.compute.amazonaws.com/schedule.json"
                Alamofire.request(url).responseObject{ (response: DataResponse<Schedule>) in
                    let scheduleResult = response.result.value
                    self.times =  scheduleResult?.times?[index].times
                    
                }
            }))
        
        }
        
        present(actionSheetController, animated: true, completion: nil)
    }
    
    func cinemaOption () {
        let actionSheetController = UIAlertController (title: "Choose Cinema", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        for cinema in self.cinemas! {
            actionSheetController.addAction(UIAlertAction(title: cinema.label, style: .default, handler:{
                action in
                self.buttonCinema.setTitle(cinema.label, for: .normal)
            }))
        }
        
        present(actionSheetController, animated: true, completion: nil)
    }
    
    func timesOption () {
        let actionSheetController = UIAlertController (title: "Choose Time", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        for times in self.times! {
            actionSheetController.addAction(UIAlertAction(title: times.label, style: .default, handler: {
                action in
                self.buttonTimes.setTitle(times.label, for: .normal)
                self.price = times.price
            }))
        }
        
        present(actionSheetController, animated: true, completion: nil)
    }

}

//extension SeatMapViewController : UICollectionViewDelegate
//{
//
//    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool
//    {
//        return true
//    }
//
//    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool
//    {
//        return true
//    }
//
//    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool
//    {
//        return true
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
//    {
////        print("Selected cell named: \(collectionViewDataSource[indexPath.row])")
//    }
//
//}

extension SeatMapViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1;
    }
    
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.arrayNumberOfSeats.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let collectionViewCell = self.seatCollectionView.dequeueReusableCell(withReuseIdentifier: "seatMap", for: indexPath) as! SeatMapCollectionViewCell
        
        
        
        collectionViewCell.bgView.backgroundColor = UIColor.gray
//        collectionViewCell.label.text = String(collectionViewDataSource[indexPath.row])
        
        return collectionViewCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
        {
    ////        print("Selected cell named: \(collectionViewDataSource[indexPath.row])")
        }
    
}
