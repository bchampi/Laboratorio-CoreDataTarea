//
//  ViewController.swift
//  CoreDataTarea
//
//  Created by Mac 17 on 5/23/21.
//  Copyright © 2021 deah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAverageE: UITextField!
    @IBOutlet weak var txtAverageL: UITextField!
    @IBOutlet weak var txtFinalE: UITextField!
    
    @IBOutlet weak var btnInsertCourse: UIButton!
    
    var course: Course? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if course != nil {
            txtName.text = course!.name
            txtAverageE.text = String(course!.examAverage)
            txtAverageE.text = String(course!.examAverage)
            txtAverageL.text = String(course!.labAverage)
            txtFinalE.text = String(course!.finalExam)
            btnInsertCourse.setTitle("Actualizar", for: .normal)
        }
    }

    @IBAction func btnAddCourse(_ sender: Any) {
        if course != nil {
            course!.name = txtName.text!
            course!.examAverage = Double(txtAverageE.text!)!
            course!.labAverage = Double(txtAverageL.text!)!
            course!.finalExam = Double(txtFinalE.text!)!
        }
        else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let course = Course(context: context)
            course.name = txtName.text!
            course.examAverage = Double(txtAverageE.text!)!
            course.labAverage = Double(txtAverageL.text!)!
            course.finalExam = Double(txtFinalE.text!)!
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
}

