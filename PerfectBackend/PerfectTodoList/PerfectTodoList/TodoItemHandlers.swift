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
Filename:     TodoItemHandlers.swift
Description:  TodoItem Handlers for REST endpoints 
Project:      PerfectTodoList
Template: /PerfectSwift/server/entityHandlerClass.swift.vm
 */

import PerfectLib

class TodoItemListHandler: RequestHandler  {
  
  func handleRequest(request: WebRequest, response: WebResponse) {
  do{
  	let todoItems : [TodoItem]  = try PersistenceManagerMySQL.sharedInstance.todoItemRepository.list()
  	print (NSJSONSerialization.isValidJSONObject (todoItems ))
  	
        let json = try TodoItem.encodeList(todoItems );
        try response.outputJson(json)
  	}catch{
  	  response.setStatus (500, message: "Could not list TodoItem data")
  	}
    //response.appendBodyString("Index handler: You accessed path \(request.requestURI())")
    response.requestCompletedCallback()
  }
}

class TodoItemCreateHandler: RequestHandler {
  func handleRequest(request: WebRequest, response: WebResponse) {
     let todoItem = TodoItem() 
     do {
    	try todoItem.decode(request.postBodyString);
    	let result = try PersistenceManagerMySQL.sharedInstance.todoItemRepository.insert(todoItem)
    	let json = try todoItem.encode()
    	try response.outputJson(json)
    }catch{
        response.appendBodyString("Error accessing data:  \(error)")
    }
    response.requestCompletedCallback()
  }
}

class TodoItemRetrieveHandler: RequestHandler {
  func handleRequest(request: WebRequest, response: WebResponse) {
   let id = Int(request.urlVariables["id"]!)
    do{
        let todoItem : TodoItem  = try PersistenceManagerMySQL.sharedInstance.todoItemRepository.retrieve(id!)!
        let json = try todoItem.encode()
        try response.outputJson(json)
    }catch{
        response.setStatus (500, message: "Could not retrieve TodoItem \(id) data")
    }
    response.requestCompletedCallback()
  }
}

class TodoItemUpdateHandler: RequestHandler {
  func handleRequest(request: WebRequest, response: WebResponse) {
    do {
     	let todoItem = TodoItem() 
    	try todoItem.decode(request.postBodyString);
    	let result = try PersistenceManagerMySQL.sharedInstance.todoItemRepository.update(todoItem)
    	let json = try todoItem.encode()
    	try response.outputJson(json)
    }catch{
        response.appendBodyString("Error accessing data:  \(error)")
    }
    response.requestCompletedCallback()
  }
}

class TodoItemDeleteHandler: RequestHandler {
  func handleRequest(request: WebRequest, response: WebResponse) {
    let id = Int(request.urlVariables["id"]!)
    do{
        let result = try PersistenceManagerMySQL.sharedInstance.todoItemRepository.delete(id!)
        //let json = try todoItem.encode()
        try response.outputJson("{\"id\":\(id),\"message\":\"deleted\"}")
    }catch{
        response.setStatus (500, message: "Could not delete TodoItem \(id) data")
    }
    response.requestCompletedCallback()
  }
}
/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 27.54 minutes to type the 2754+ characters in this file.
 */
