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
Filename:     Task.swift
Description:  Class that holds the data for Task
Project:      PerfectTodoList
Template: SwiftData/Entity.swift.vm
 */

import SwiftyJSON
import Foundation

class Task  {

    var completed : Bool!
    var id : Int!
    var order : Int!
    var title : String!
    var todo : TodoItem!
    
    
  func toDictionary() -> Dictionary<String, AnyObject> {
		var dict =  Dictionary<String, AnyObject>()
		if(completed != nil){
		   dict["completed"] = completed
		}
		if(id != nil){
		   dict["id"] = id
		}
		if(order != nil){
		   dict["order"] = order
		}
		if(title != nil){
		   dict["title"] = title
		}
		if(todo != nil){
	       dict["todo"] = todo.toDictionary();
		}
		return dict        
	}
	
	
   static func deserialize(json : JSON) -> Task {
   let task = Task()
		if(json["completed"] != nil){
			task.completed =  json["completed"].bool 
		}
		if(json["id"] != nil){
			task.id =  json["id"].Long 
		}
		if(json["order"] != nil){
			task.order =  json["order"].int 
		}
		if(json["title"] != nil){
			task.title =  json["title"].string 
		}
		if(json["todo"] != nil){
 			task.todo =  TodoItem.deserialize(json["todo"])
		}
			return task	
    }  
    
     
    static func deserialize(jsonString : String) throws -> Task {
        if let dataFromString = jsonString.data(usingEncoding: NSUTF8StringEncoding, allowLossyConversion: false) {
    		let json = JSON(data: dataFromString)
    		return Task.deserialize(json)
		}
		throw PerfectTodoListErrors.NoDataForJSON;
    }
    
    static func serialize(entity : Task) -> JSON {
		let json =  JSON(entity.toDictionary())
		return json        
	}
	
	static func encode(entity : Task) throws -> JSON! {
        let json = Task.serialize(entity)
        return json 
    }
    
    static func encodeList(elements : Array<Task>) throws -> JSON {
          var list = [JSON]();
          for element in elements {
              let json = Task.serialize(element)
              list.append(json)
          }
          return JSON(list)
    }
}
/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 19.65 minutes to type the 1965+ characters in this file.
 */
