//
//  HabitsViewController.swift
//  Habits
//
//  Created by James Brown on 9/18/16.
//  Copyright © 2016 James Brown. All rights reserved.
//

import UIKit
import CoreData

class HabitsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var controller: NSFetchedResultsController<Habit>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchHabits()
    }
    
    // MARK: table protocols
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections {
            return sections.count
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections {
            return sections[section].numberOfObjects
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HabitCell") {
            configureCell(cell: cell, indexPath: indexPath)
            return cell
            
        }
        
        return UITableViewCell()
    }
    
    // MARK: fetched results controller
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case.insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            if let indexPath = indexPath {
                if let cell = tableView.cellForRow(at: indexPath) {
                    configureCell(cell: cell, indexPath: indexPath)
                }
            }
            break
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
    }
    
//    println(self.appdel.fromdate) // prints 2015-09-25
//    println(self.appdel.todate) // prints 2015-09-26
//    
//    var fromdate = "\(self.appdel.fromdate) 00:00" // add hours and mins to fromdate
//    var todate = "\(self.appdel.todate) 23:59" // add hours and mins to todate
//    
//    var context : NSManagedObjectContext = appdel.managedObjectContext!
//    var request = NSFetchRequest(entityName: "TblReportsP")
//    request.returnsObjectsAsFaults = false
//    let dateFormatter = NSDateFormatter()
//    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
//    dateFormatter.timeZone = NSTimeZone(name: "GMT") // this line resolved me the issue of getting one day less than the selected date
//    let startDate:NSDate = dateFormatter.dateFromString(fromdate)!
//    let endDate:NSDate = dateFormatter.dateFromString(todate)!
//    request.predicate = NSPredicate(format: "(date >= %@) AND (date <= %@)", startDate, endDate)
//    
//    request.sortDescriptors = [NSSortDescriptor(key: "report_id", ascending: false)]
//    var results : NSArray = context.executeFetchRequest(request, error: nil)!
//    
//    println(results.count)
    
    
    // MARK: functions
    func fetchHabits() {
        let fetchRequest: NSFetchRequest<Habit> = Habit.fetchRequest()
        
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [nameSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        self.controller = controller
        
        controller.delegate = self
        
        do {
            try controller.performFetch()
        } catch {
            let error = error as NSError 
            print("JAMES: \(error)")
        }
    }
    
    func configureCell(cell: UITableViewCell, indexPath: IndexPath) {
        let habit = controller.object(at: indexPath)
        cell.textLabel?.text = "\(habit.lastEntry)"
    }

}
