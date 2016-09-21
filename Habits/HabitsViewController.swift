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
    
    // MARK: IBActions
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        fetchHabits()
        tableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let done = UITableViewRowAction(style: .normal, title: "Done") { action, index in
            self.markAsDone(indexPath: indexPath)
        }
        done.backgroundColor = #colorLiteral(red: 0.2980392157, green: 0.6862745098, blue: 0.3137254902, alpha: 1)
        
        let notDone = UITableViewRowAction(style: .normal, title: "Not Done") { action, index in
            self.markAsNotDone(indexPath: indexPath)
        }
        notDone.backgroundColor = UIColor.gray
        
        if segment.selectedSegmentIndex == 0 {
            return [done]
        }
        
        return [notDone]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
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
    
    
    // MARK: functions
    
    func fetchHabits() {
        let fetchRequest: NSFetchRequest<Habit> = Habit.fetchRequest()
        
        
        // predicates
        
        let today = NSCalendar.current.startOfDay(for: Date())
        let datePredicate: NSPredicate
        
        if segment.selectedSegmentIndex == 0 {
            datePredicate = NSPredicate(format: "lastEntry < %@", today as CVarArg)
        } else  {
            datePredicate = NSPredicate(format: "lastEntry > %@", today as CVarArg)
        }
        
        fetchRequest.predicate = datePredicate
        
        
        // sort descriptors
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
        cell.textLabel?.text = habit.name
    }
    
    func markAsDone(indexPath: IndexPath) {
        let habit = controller.object(at: indexPath)
        habit.lastEntry = Date()
        
        ad.saveContext()
    }
    
    func markAsNotDone(indexPath: IndexPath) {
        let habit = controller.object(at: indexPath)
        
        if let yesterday = NSCalendar.current.date(byAdding: .day, value: -1, to: Date()) {
            habit.lastEntry = yesterday
            ad.saveContext()
        }
    }

}



