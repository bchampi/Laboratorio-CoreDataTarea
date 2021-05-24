//
//  TableViewController.swift
//  CoreDataTarea
//
//  Created by Mac 17 on 5/23/21.
//  Copyright © 2021 deah. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var courses: [Course] = []

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            try courses = context.fetch(Course.fetchRequest())
            tableView.reloadData()
        } catch {
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let course = courses[indexPath.row]
        let result: Double = (course.examAverage * 0.30) + (course.labAverage * 0.70)
        if result < 13.0 {
            cell.backgroundColor = UIColor.red
            cell.textLabel?.text = "\(course.name!) - \(result)"
        } else {
            cell.backgroundColor = UIColor.green
            cell.textLabel?.text = "\(course.name!) - \(round(result * 100) / 100.0)"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let course = courses[indexPath.row]
        performSegue(withIdentifier: "addCourse", sender: course)
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        courses.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let btnUpdate = UITableViewRowAction(style: .normal, title: "Actualizar") {
         (actionRow, indexRow) in
            let course = self.courses[indexPath.row]
            self.performSegue(withIdentifier: "addCourse", sender: course)
        }
        btnUpdate.backgroundColor = UIColor.systemBlue

        let btnDelete = UITableViewRowAction(style: .normal, title: "Eliminar") {
         (actionRow, indexRow) in
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(self.courses.remove(at: indexPath.row))
            tableView.reloadData()
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
        btnDelete.backgroundColor = UIColor.black
        
        self.navigationController?.popViewController(animated: true)
        tableView.reloadData()

        return[btnUpdate, btnDelete]
    }
    
    @IBAction func actionCell(_ sender: Any) {
        if tableView.isEditing {
            tableView.isEditing = false
        } else {
            tableView.isEditing = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let afterVC = segue.destination as! ViewController
        afterVC.course = sender as? Course
    }

}
