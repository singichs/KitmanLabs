//
//  AthletesTableViewController.swift
//  KitmanLabs
//

import UIKit

class AthletesTableViewController: UITableViewController {
    
    var contentService = ContentService()
    
    private let reuseIdentifier = "athleteCell"
    private let detailsSegueIdentifier = "showDetails"
    private var athletes = [Athlete]()
    private var squads = [Squad]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchAthletes(completion: {
            print("\(self.athletes.count) athletes retrieved")
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                self.tableView.reloadData()
            }
        })
        
        fetchSquads(completion: {
            print("\(self.squads.count) squads retrieved")
        })
    }
    
    private func fetchAthletes(completion: @escaping (() -> ())) {
        contentService.retrieveAthletes(completionHandler: { (result) in
            self.athletes = result
            completion()
        })
    }
    
    private func fetchSquads(completion: @escaping (() -> ())) {
        contentService.retrieveSquad(completionHandler: { (result) in
            self.squads = result
            completion()
        })
    }
    
    private func generateSquads(from ids: [Int]) -> String {
        var str: String = ""
        
        for id in ids {
            let squad: Squad? = self.squads.first(where: { $0.id == id })
            
            if let squad = squad {
                if str == "" {
                    str = squad.name
                } else {
                    str += ", \(squad.name)"
                }
            }
        }

        return str
            
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return athletes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? AthleteTableViewCell else {
            fatalError("Did not get expected TableViewCell. Expected AthleteTableViewCell")
        }
        let athlete = athletes[indexPath.row]
        
        // Configure the cell...
        cell.configure(firstName: athlete.firstName, lastName: athlete.lastName, url: athlete.image.url)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let athlete = athletes[indexPath.row]
        let name = athlete.firstName + " " + athlete.lastName
        let squadNames = generateSquads(from: athlete.squadIds)
        
        let details = PlayerDetails(playerName: name, username: athlete.username, squad: squadNames, url: athlete.image.url)
        
        performSegue(withIdentifier: detailsSegueIdentifier, sender: details)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailsSegueIdentifier {
            if let detailsVC = segue.destination as? AthleteDetailsViewController {
                if let athleteDetails = sender as? PlayerDetails {
                    detailsVC.playerDetails = athleteDetails
                }
            }
        }
    }
    

}
