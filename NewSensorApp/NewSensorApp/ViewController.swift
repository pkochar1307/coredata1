//
//  ViewController.swift
//  NewSensorApp
//
//  Created by Capgemini on 10/09/19.
//  Copyright © 2019 Capgemini. All rights reserved.
//

import UIKit
import  CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
  // class CustomCell : UITableViewCell{
    
   @IBOutlet weak var id: UITextField!
    @IBOutlet weak var sensorname: UITextField!
    
    @IBOutlet weak var desc: UITextView!
    
    
    @IBOutlet weak var tableView: UITableView!
  //  }
    
    @IBAction func createData(_ sender: Any) {
        createData()
   }
    
    
    var lastCount : Int = 0
    var window: UIWindow?
    var item :[Any] = []
    var dict = NSMutableDictionary()
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //registerTableViewCell()
       // self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
       // tableView.delegate=self as! UITableViewDelegate
       // tableView.dataSource=self as! UITableViewDataSource
        
        let context = appdelegate.persistentContainer.viewContext
        var locations = [Details]() // Login is your Entity name
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Details")
        fetchRequest.returnsObjectsAsFaults = false
        locations = try! context.fetch(fetchRequest) as! [Details]
        
        for location in locations
        {
            item.append(location) // item is your array
        }
        
        lastCount = item.count
    }
    
   let nscontext = ((UIApplication.shared.delegate) as!
        AppDelegate).persistentContainer.viewContext
  
    
    func registerTableViewCell(){
        let label1 = UINib(nibName: "SensorCell", bundle: nil);
        self.tableView.register(label1, forCellReuseIdentifier: "myCell")
    }
    func createData()
    {
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Details",
                                                         into: nscontext)
        
        entity.setValue(sensorname.text, forKey:"sensorname") // sensorname is a Your Entity Key
        entity.setValue(desc.text, forKey: "desc")
        entity.setValue(Int(id.text!) , forKey: "id")
        do
        {
            try nscontext.save()
            sensorname.text = ""
            desc.text = ""
        }
        catch
        {
            
        }
        print("Record Inserted")
        self.navigationController?.popViewController(animated: true)
    }
      
  
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int
    {
        return item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! SensorCellTableViewCell // CustomCell is your Cell File name
        let dic = item[indexPath.row] as! NSManagedObject
        //cell.sensorname?.text = dic.value(forKey: "sensorname" ) as? String
        //cell.desc?.text = dic.value(forKey: "desc" ) as? String
        cell.sensorName.text=dic.value(forKey: "sensorname" ) as? String;     cell.sensorDesc.text=dic.value(forKey: "desc" ) as? String
        let senId=dic.value(forKey: "id" ) as? Int64

        cell.sensorId.text = "\(String(describing: senId ?? 0))"

        return cell
    }
   
}//end of class



