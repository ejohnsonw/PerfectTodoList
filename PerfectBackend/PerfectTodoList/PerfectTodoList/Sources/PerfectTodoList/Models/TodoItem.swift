/* 
Copyright (c) 2016 NgeosOne LLC
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

   
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), 
 to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
 and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.

Engineered using http://www.generatron.com/

[GENERATRON]
Generator :   System Templates
Filename:     TodoItem.swift
Description:  Class that holds the data for TodoItem
Project:      PerfectTodoList
Template: SwiftData/Entity.swift.vm
 */

import SwiftyJSON
import Foundation

class TodoItem  {

    var dueDate : NSDate!
    var id : Int!
    var notes : String!
    var status : Status!
    var tasks : Task!
    var title : String!
    
    
  func toDictionary() -> Dictionary<String, AnyObject> {
		var dict =  Dictionary<String, AnyObject>()
		if(dueDate != nil){
	       dict["dueDate"] = dueDate.SQLDateString;
		}
		if(id != nil){
		   dict["id"] = id
		}
		if(notes != nil){
		   dict["notes"] = notes
		}
		if(status != nil){
	       dict["status"] = status.toDictionary();
		}
		if(tasks != nil){
	       dict["tasks"] = tasks.toDictionary();
		}
		if(title != nil){
		   dict["title"] = title
		}
		return dict        
	}
	
	
   static func deserialize(json : JSON) -> TodoItem {
   let todoItem = TodoItem()
		if(json["dueDate"] != nil){
     		todoItem.dueDate =  json["dueDate"].string!.SQLStringDate()
		}
		if(json["id"] != nil){
			todoItem.id =  json["id"].Long 
		}
		if(json["notes"] != nil){
			todoItem.notes =  json["notes"].string 
		}
		if(json["status"] != nil){
 			todoItem.status =  Status.deserialize(json["status"])
		}
		if(json["tasks"] != nil){
 			todoItem.tasks =  Task.deserialize(json["tasks"])
		}
		if(json["title"] != nil){
			todoItem.title =  json["title"].string 
		}
			return todoItem	
    }  
    
     
    static func deserialize(jsonString : String) throws -> TodoItem {
        if let dataFromString = jsonString.data(usingEncoding: NSUTF8StringEncoding, allowLossyConversion: false) {
    		let json = JSON(data: dataFromString)
    		return TodoItem.deserialize(json)
		}
		throw PerfectTodoListErrors.NoDataForJSON;
    }
    
    static func serialize(entity : TodoItem) -> JSON {
		let json =  JSON(entity.toDictionary())
		return json        
	}
	
	static func encode(entity : TodoItem) throws -> JSON! {
        let json = TodoItem.serialize(entity)
        return json 
    }
    
    static func encodeList(elements : Array<TodoItem>) throws -> JSON {
          var list = [JSON]();
          for element in elements {
              let json = TodoItem.serialize(element)
              list.append(json)
          }
          return JSON(list)
    }
}
/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 22.62 minutes to type the 2262+ characters in this file.
 */
