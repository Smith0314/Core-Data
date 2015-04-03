//
//  ViewController.swift
//  Core-Data
//
//  Created by Smith on 2015/4/1.
//  Copyright (c) 2015年 Smith-Lab. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var logo:UILabel!
    var fieldName:UITextField!
    var fieldEmail:UITextField!
    var fieldPhone:UITextField!
    var btnEdit:UIButton!
    var btnDelete:UIButton!
    var btnAdd:UIButton!
    var btnSave:UIButton!
    var tableShow:UITableView!
    var halfHeight:CGFloat!
    var theWidth:CGFloat!
    var elementHeight:CGFloat!
    var elementWidth:CGFloat!
    var theFont:String = "HelveticaNeue-Thin"
    var fontSize:CGFloat!
    var result:Array<Member> = []
    var currentStu = 0
    let cellIdentifier = "cell_indentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blackColor()
        
        halfHeight = (view.bounds.height / 2) - 25
        theWidth = view.bounds.width - 40
        elementHeight = (halfHeight - 40) / 5
        elementWidth = (theWidth - 30) / 4
        fontSize = elementHeight * 0.4
        
        logo = UILabel()
        logo.frame = CGRect(x: 20, y: 20, width: theWidth, height: elementHeight)
        logo.font = UIFont(name:"untitled-font-1", size:elementHeight)
        logo.textColor = UIColor.whiteColor()
        logo.textAlignment = .Center
        logo.text = "s"
        
        fieldName = UITextField()
        fieldName.frame = CGRect(x: 20, y: elementHeight + 30, width: theWidth, height: elementHeight)
        fieldEmail = UITextField()
        fieldEmail.frame = CGRect(x: 20, y: (elementHeight * 2) + 40, width: theWidth, height: elementHeight)
        fieldPhone = UITextField()
        fieldPhone.frame = CGRect(x: 20, y: (elementHeight * 3) + 50, width: theWidth, height: elementHeight)
        
        var ve1:UIVisualEffectView = UIVisualEffectView()
        var ve2:UIVisualEffectView = UIVisualEffectView()
        var ve3:UIVisualEffectView = UIVisualEffectView()
        var ve4:UIVisualEffectView = UIVisualEffectView()
        var ve5:UIVisualEffectView = UIVisualEffectView()
        var ve6:UIVisualEffectView = UIVisualEffectView()
        var ve7:UIVisualEffectView = UIVisualEffectView()
        
        var veFieldArray:Array<UIVisualEffectView> = [ve1, ve2, ve3]
        var veBtnArray:Array<UIVisualEffectView> = [ve4, ve5, ve6, ve7]
        
        var fieldArray:Array<UITextField> = [fieldName, fieldEmail, fieldPhone]
        var iconArray:Array<String> = ["b","a","e"]
        for (index, value) in enumerate(fieldArray){
            value.font = UIFont(name:theFont, size:fontSize)
            value.textColor = UIColor.whiteColor()
            
            let currencyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: elementHeight-10, height: elementHeight-10))
            currencyLabel.font = UIFont(name:"untitled-font-1", size:fontSize)
            currencyLabel.text = iconArray[index]
            currencyLabel.textColor = UIColor.whiteColor()
            currencyLabel.textAlignment = .Center
            value.leftView = currencyLabel
            value.leftViewMode = .Always
            value.delegate = self
            
            veFieldArray[index] = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
            veFieldArray[index].frame = value.frame
            view.insertSubview(veFieldArray[index], atIndex: index+1)
            view.addSubview(value)
        }
        
        btnEdit = UIButton()
        btnEdit.frame = CGRect(x: 20, y: (elementHeight * 4) + 60, width: elementWidth, height: elementHeight)
        btnEdit.setTitle("EDIT", forState: UIControlState.Normal)
        btnEdit.addTarget(self, action: "modifyClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        btnDelete = UIButton()
        btnDelete.frame = CGRect(x: elementWidth + 30, y: (elementHeight * 4) + 60, width: elementWidth, height: elementHeight)
        btnDelete.setTitle("DELETE", forState: UIControlState.Normal)
        btnDelete.addTarget(self, action: "deleteClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        btnAdd = UIButton()
        btnAdd.frame = CGRect(x: (elementWidth * 2) + 40, y: (elementHeight * 4) + 60, width: elementWidth, height: elementHeight)
        btnAdd.setTitle("ADD", forState: UIControlState.Normal)
        btnAdd.addTarget(self, action: "insertClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        btnSave = UIButton()
        btnSave.frame = CGRect(x: (elementWidth * 3) + 50, y: (elementHeight * 4) + 60, width: elementWidth, height: elementHeight)
        btnSave.setTitle("SAVE", forState: UIControlState.Normal)
        btnSave.addTarget(self, action: "writeClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        var btnArray:Array<UIButton> = [btnEdit, btnDelete, btnAdd, btnSave]
        for (index, value) in enumerate(btnArray){
            value.titleLabel?.font = UIFont(name:theFont, size:fontSize * 0.8)
            veBtnArray[index] = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
            veBtnArray[index].frame = value.frame
            view.insertSubview(veBtnArray[index], atIndex: index+3)
            view.addSubview(value)
        }
        
        tableShow = UITableView()
        tableShow.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
        tableShow.frame = CGRect(x: 20, y: (view.bounds.height / 2) + 5, width: theWidth, height: halfHeight)
        tableShow.delegate = self
        tableShow.dataSource = self
        tableShow.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "bg")?.drawInRect(self.view.bounds)
        
        var bgImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage:bgImage)
        
        var appDele:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var context:NSManagedObjectContext = appDele.managedObjectContext!
        var fetch:NSFetchRequest = NSFetchRequest(entityName: "Member")
        result = context.executeFetchRequest(fetch, error: nil) as Array<Member>
        initData()
        tableShow.reloadData()
        firstData(0)
        fieldName.enabled = false
        
        view.addSubview(logo)
        view.addSubview(btnEdit)
        view.addSubview(btnDelete)
        view.addSubview(btnAdd)
        view.addSubview(btnSave)
        view.addSubview(tableShow)
    }
    
    
    //Updata
    func modifyClick(sender: UIButton) {
        var alertModify:UIAlertView = UIAlertView()
        alertModify.title = "UPDATE"
        alertModify.message = "Will overwrite data"
        alertModify.delegate = self
        alertModify.addButtonWithTitle("OK")
        alertModify.addButtonWithTitle("CANCEL")
        alertModify.show()
    }
    
    //Delete
    func deleteClick(sender: UIButton) {
        if result.count > 1 {
            var alertDelete:UIAlertView = UIAlertView()
            alertDelete.title = "DELETE"
            alertDelete.message = "Will delete data"
            alertDelete.delegate = self
            alertDelete.addButtonWithTitle("OK")
            alertDelete.addButtonWithTitle("CANCEL")
            alertDelete.show()
        } else {
            println("Only one data can't delete！")
        }
    }
    
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int){
        if alertView.title == "EDIT" {
            switch (buttonIndex) {
            case 0:
                var appDele:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
                var context:NSManagedObjectContext = appDele.managedObjectContext!
                var fetch:NSFetchRequest = NSFetchRequest(entityName: "Member")
                var member:Array<Member> = []
                fetch.predicate = NSPredicate(format: "name = %@", result[currentStu].name)
                member = context.executeFetchRequest(fetch, error: nil) as Array<Member>
                member[0].email = fieldEmail.text
                member[0].phone = fieldPhone.text.toInt()!
                appDele.managedObjectContext?.save(nil)
                fetch.predicate = nil
                result = context.executeFetchRequest(fetch, error: nil) as [Member]
                tableShow.reloadData()
            default:
                break
            }
        } else if alertView.title == "DELETE" {
            switch (buttonIndex) {
            case 0:
                var appDele:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
                var context:NSManagedObjectContext = appDele.managedObjectContext!
                var fetch:NSFetchRequest = NSFetchRequest(entityName: "Member")
                var member:Array<Member> = []
                fetch.predicate = NSPredicate(format: "name = %@", result[currentStu].name)
                member = context.executeFetchRequest(fetch, error: nil) as Array<Member>
                appDele.managedObjectContext?.deleteObject(member[0])
                appDele.managedObjectContext?.save(nil)
                fetch.predicate = nil
                result = context.executeFetchRequest(fetch, error: nil) as [Member]
                tableShow.reloadData()

                if currentStu == result.count {
                    --currentStu
                }
                firstData(currentStu)
            default:
                break
            }
        }
    }
    
    //ADD
    func insertClick(sender: UIButton) {
        btnAdd.enabled = false
        btnSave.enabled = true
        fieldName.enabled = true
        fieldName.text = ""
        fieldEmail.text = ""
        fieldPhone.text = ""
    }
    
    //SAVE
    func writeClick(sender: UIButton) {
        btnAdd.enabled = true
        btnSave.enabled = false
        fieldName.enabled = false
        var appDele:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var context:NSManagedObjectContext = appDele.managedObjectContext!
        var fetch:NSFetchRequest = NSFetchRequest(entityName: "Member")
        var member:Member
        member = NSEntityDescription.insertNewObjectForEntityForName("Member", inManagedObjectContext: appDele.managedObjectContext!) as Member
        member.name = fieldName.text
        member.email = self.fieldEmail.text
        member.phone = self.fieldPhone.text.toInt()!
        appDele.managedObjectContext?.save(nil)
        result = context.executeFetchRequest(fetch, error: nil) as Array<Member>
        tableShow.reloadData()
        currentStu = result.count - 1
    }
    
    func firstData(n:Int) {
        fieldName.text = result[n].name
        fieldEmail.text = result[n].email
        fieldPhone.text = "\(result[n].phone)"
    }
    
    func initData() {
        if result.count == 0 {
            var appDele:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            var context:NSManagedObjectContext = appDele.managedObjectContext!
            var fetch:NSFetchRequest = NSFetchRequest(entityName: "Member")
            var member:Member
            member = NSEntityDescription.insertNewObjectForEntityForName("Member", inManagedObjectContext: context) as Member
            member.name = "Callie"
            member.email = "callie@smith.com"
            member.phone = 0900000000
            context.save(nil)
            member = NSEntityDescription.insertNewObjectForEntityForName("Member", inManagedObjectContext: context) as Member
            member.name = "Cecelia"
            member.email = "cecelia@smith.com"
            member.phone = 0911011011
            context.save(nil)
            member = NSEntityDescription.insertNewObjectForEntityForName("Member", inManagedObjectContext: context) as Member
            member.name = "Chiquita"
            member.email = "chiquita@smith.com"
            member.phone = 0922022022
            context.save(nil)
            member = NSEntityDescription.insertNewObjectForEntityForName("Member", inManagedObjectContext: context) as Member
            member.name = "Claudette"
            member.email = "claudette@smith.com"
            member.phone = 0933033033
            context.save(nil)
            member = NSEntityDescription.insertNewObjectForEntityForName("Member", inManagedObjectContext: context) as Member
            member.name = "Cleopatra"
            member.email = "cleopatra@smith.com"
            member.phone = 0944044044
            context.save(nil)
            result = context.executeFetchRequest(fetch, error: nil) as [Member]
        }
    }
    
    
    //TableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell
        
        cell = UITableViewCell(style: UITableViewCellStyle.Subtitle,reuseIdentifier: cellIdentifier)
        cell.textLabel?.text = "\(result[indexPath.row].name)"
        cell.textLabel?.font = UIFont(name: theFont, size: (halfHeight / 5) * 0.4)
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.detailTextLabel?.text = "Email：\(result[indexPath.row].email)   Phone：\(result[indexPath.row].phone)"
        cell.detailTextLabel?.font = UIFont(name: "HelveticaNeue-Light", size: (halfHeight / 5) * 0.2)
        cell.detailTextLabel?.textColor = UIColor.whiteColor()
        cell.backgroundColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        
        return cell
        
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        btnAdd.enabled = true
        btnSave.enabled = false
        currentStu = indexPath.row
        firstData(currentStu)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return halfHeight / 5
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


