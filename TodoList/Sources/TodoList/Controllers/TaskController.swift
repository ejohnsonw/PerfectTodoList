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
Filename:     TaskController.swift
Description:  Task Handlers for REST endpoints 
Project:      TodoList
Template: /Kitura-REST/server/EntityController.swift.vm
 */

import Kitura
import KituraNet
import KituraSys

import HeliumLogger
import LoggerAPI

import Foundation

class TaskController  {
	var pm : PersistenceManager!
	 
	init(persistenceManager : PersistenceManager){
	self.pm = persistenceManager;
	 TodoListRouter.sharedInstance.get("/api/task"){ request, response, next in
	    do{
	    	print("Adding route: /api/task ")
	        let tasks : [Task]  = try self.pm.taskRepository.list()
	        let json = try Task.encodeList(tasks);
	        response.status(HttpStatusCode.OK).sendJson(json)
	  	}catch{
	  	    try! response.status(HttpStatusCode.INTERNAL_SERVER_ERROR).end();
	  	}
	    next()
	  }
	
	
	  TodoListRouter.sharedInstance.post("/api/task"){ request, response, next in
	     do {
	     	if let body = request.body {
            	if let json = body.asJson() {
	                let task =  Task.deserialize(json);
		    		try self.pm.taskRepository.insert(task)
		    		let json = try Task.encode(task)
		    		response.status(HttpStatusCode.OK).sendJson(json)
            	}
	        } else {
	            response.status(HttpStatusCode.BAD_REQUEST)
	        }
	    }catch{
	        try! response.status(HttpStatusCode.INTERNAL_SERVER_ERROR).end();
	    }
	    next()
	 }
	
	 TodoListRouter.sharedInstance.get("/api/task/:id"){ request, response, next in
	   let id = Int(request.params["id"]!)
	    do{
	        let task : Task?  = try self.pm.taskRepository.retrieve(id!)
	        
	        if(task != nil){
	        	let json = try Task.encode(task!)
	        	response.status(HttpStatusCode.OK).sendJson(json)
	        }else{
	        	try! response.status(HttpStatusCode.INTERNAL_SERVER_ERROR).end();
	        }
	    }catch{
	        try! response.status(HttpStatusCode.INTERNAL_SERVER_ERROR).end();
	    }
	    next()
	 }
	
	 TodoListRouter.sharedInstance.put("/api/task/:id"){ request, response, next in
	    do {
	     	if let body = request.body {
            	if let json = body.asJson() {
	                let task =  Task.deserialize(json);
		    		try self.pm.taskRepository.update(task)
		    		let json = try Task.encode(task)
		    		response.status(HttpStatusCode.OK).sendJson(json)
            	}
	        } else {
	            response.status(HttpStatusCode.BAD_REQUEST)
	        }
	    }catch{
	        try! response.status(HttpStatusCode.INTERNAL_SERVER_ERROR).end();
	    }
	    next()
	 }

	 TodoListRouter.sharedInstance.delete("/api/task/:id"){ request, response, next in
	    let id = Int(request.params["id"]!)
	    do{
	        try self.pm.taskRepository.delete(id!)
	        //response.status(HttpStatusCode.OK).sendJson(json)
	        try response.status(HttpStatusCode.OK).end()
	    }catch{
	        try! response.status(HttpStatusCode.INTERNAL_SERVER_ERROR).end()
	    }
	    next()
	 }
  }
}
/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 28.8 minutes to type the 2880+ characters in this file.
 */
