# Managed-Core-Data
Managed Core Data, built using Swift, without storyboard

*Core Data
-------------------------------------------------------------------

一個操作 iOS Core Data 資料庫的範例，可編輯、新增及刪除資料，並於下方顯示所有資料記錄

        var appDele:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var context:NSManagedObjectContext = appDele.managedObjectContext!
        var fetch:NSFetchRequest = NSFetchRequest(entityName: "Member")
        result = context.executeFetchRequest(fetch, error: nil) as Array<Member>

.        

*Auto Layout
-------------------------------------------------------------------

元件邊界及間距固定，各元件尺寸及字型隨不同螢幕尺寸自動調整尺寸

![image](https://github.com/Smith0314/Managed-Core-Data/blob/master/screenshot/screenshot.jpg)

        halfHeight = (view.bounds.height / 2) - 25
        theWidth = view.bounds.width - 40
        elementHeight = (halfHeight - 40) / 5
        elementWidth = (theWidth - 30) / 4
        fontSize = elementHeight * 0.4

        fieldName.frame = CGRect(x: 20, y: elementHeight + 30, width: theWidth, height: elementHeight)
        fieldEmail.frame = CGRect(x: 20, y: (elementHeight * 2) + 40, width: theWidth, height: elementHeight)
        fieldPhone.frame = CGRect(x: 20, y: (elementHeight * 3) + 50, width: theWidth, height: elementHeight)

        btnEdit.frame = CGRect(x: 20, y: (elementHeight * 4) + 60, width: elementWidth, height: elementHeight)
        btnDelete.frame = CGRect(x: elementWidth + 30, y: (elementHeight * 4) + 60, width: elementWidth, height: elementHeight)
        btnAdd.frame = CGRect(x: (elementWidth * 2) + 40, y: (elementHeight * 4) + 60, width: elementWidth, height: elementHeight)
        btnSave.frame = CGRect(x: (elementWidth * 3) + 50, y: (elementHeight * 4) + 60, width: elementWidth, height: elementHeight)
        
       tableShow.frame = CGRect(x: 20, y: (view.bounds.height / 2) + 5, width: theWidth, height: halfHeight)

       func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
         return halfHeight / 5
       }

.

*Element Blur Background
-------------------------------------------------------------------

以列舉廻圈的方式將 UITextField 及 UIButton 背影模糊化

          for (index, value) in enumerate(fieldArray){
            veFieldArray[index] = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
            veFieldArray[index].frame = value.frame
            view.insertSubview(veFieldArray[index], atIndex: index+1)
            view.addSubview(value)
          }
