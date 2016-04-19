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
Filename:     PerfectHandlers.swift
Description:  Swift Server
Project:      PerfectTodoList
Template: /PerfectSwift/server/ServerModuleInit.swift.vmg
 */

import PerfectLib

public func PerfectServerModuleInit() {
	
	PageHandlerRegistry.addPageHandler("IndexHandler") {
		
		// This closure is called in order to create the handler object.
		// It is called once for each relevant request.
		// The supplied WebResponse object can be used to tailor the return value.
		// However, all request processing should take place in the `valuesForResponse` function.
		(r:WebResponse) -> PageHandler in
		
		return IndexHandler()
	}
	
	
	Routing.Handler.registerGlobally()
	Routing.Routes["GET", ["/assets/*/*"]] = { _ in return StaticFileHandler() }
	Routing.Routes["GET", ["/uploads/*"]] = { _ in return StaticFileHandler() }
  	
  	
	//Routes for Status
	Routing.Routes["GET", ["/api/status"] ] = { (_:WebResponse) in return StatusListHandler() }
	Routing.Routes["POST", ["/api/status"] ] = { (_:WebResponse) in return StatusCreateHandler() }
	Routing.Routes["GET", "/api/status/{id}"] = { _ in return StatusRetrieveHandler() }
	Routing.Routes["PUT", "/api/status/{id}"] = { _ in return StatusUpdateHandler() }
	Routing.Routes["POST", "/api/status/{id}"] = { _ in return StatusUpdateHandler() }
	Routing.Routes["DELETE", "/api/status/{id}"] = { _ in return StatusDeleteHandler() }
	
	//Routes for Task
	Routing.Routes["GET", ["/api/task"] ] = { (_:WebResponse) in return TaskListHandler() }
	Routing.Routes["POST", ["/api/task"] ] = { (_:WebResponse) in return TaskCreateHandler() }
	Routing.Routes["GET", "/api/task/{id}"] = { _ in return TaskRetrieveHandler() }
	Routing.Routes["PUT", "/api/task/{id}"] = { _ in return TaskUpdateHandler() }
	Routing.Routes["POST", "/api/task/{id}"] = { _ in return TaskUpdateHandler() }
	Routing.Routes["DELETE", "/api/task/{id}"] = { _ in return TaskDeleteHandler() }
	
	//Routes for TodoItem
	Routing.Routes["GET", ["/api/todoItem"] ] = { (_:WebResponse) in return TodoItemListHandler() }
	Routing.Routes["POST", ["/api/todoItem"] ] = { (_:WebResponse) in return TodoItemCreateHandler() }
	Routing.Routes["GET", "/api/todoItem/{id}"] = { _ in return TodoItemRetrieveHandler() }
	Routing.Routes["PUT", "/api/todoItem/{id}"] = { _ in return TodoItemUpdateHandler() }
	Routing.Routes["POST", "/api/todoItem/{id}"] = { _ in return TodoItemUpdateHandler() }
	Routing.Routes["DELETE", "/api/todoItem/{id}"] = { _ in return TodoItemDeleteHandler() }
	
	print("\(Routing.Routes.description)") 
	//Initialize PM and repositories  
	PersistenceManagerMySQL.sharedInstance
}

/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 24.93 minutes to type the 2493+ characters in this file.
 */
