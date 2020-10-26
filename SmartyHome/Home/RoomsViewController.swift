//
//  RoomsViewController.swift
//  SmartyHome
//
//  Created by Ahmed MAHOUCHI on 10/25/20.
//

import Foundation
import UIKit

class RoomsViewController: UIViewController {

    @IBOutlet weak var emptyView: UIView?
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var welocomeLbl: UILabel!
    
    fileprivate let roomPresenter = RoomPresenter(roomService: RoomService())
    fileprivate var roomsToDisplay = [RoomViewData]()
    var username : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = self
        activityIndicator?.hidesWhenStopped = true

        roomPresenter.attachView(self)
        tableView?.register(UINib(nibName: "RoomViewCell", bundle: nil), forCellReuseIdentifier: "RoomViewCell")
        welocomeLbl.text = "Welcome,\(username)!"
        dateLbl.text = Date().toString(dateFormat: "MMMM dd,YYYY")
        tableView?.separatorColor = .clear
        roomPresenter.getRooms()
    }

}

extension RoomsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomsToDisplay.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"RoomViewCell", for: indexPath as IndexPath) as! RoomViewCell
        let roomViewData = roomsToDisplay[indexPath.row]
        cell.roomName?.text = roomViewData.name
        cell.devicesNumber?.text = roomViewData.devicesNumber
        cell.roomImage.image = UIImage(named: roomViewData.image)
        cell.selectionStyle = .none
        return cell
    }

}

extension RoomsViewController: RoomView {

    func startLoading() {
        activityIndicator?.startAnimating()
    }

    func finishLoading() {
        activityIndicator?.stopAnimating()
    }

    func setRooms(_ rooms: [RoomViewData]) {
        roomsToDisplay = rooms
        tableView?.isHidden = false
        emptyView?.isHidden = true;
        tableView?.reloadData()
    }

    func setEmptyRooms() {
        tableView?.isHidden = true
        emptyView?.isHidden = false;
    }


}

