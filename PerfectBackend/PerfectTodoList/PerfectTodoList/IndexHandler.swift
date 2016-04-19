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
Filename:     IndexHandler.swift
Description:  Swift Server
Project:      PerfectTodoList
Template: /PerfectSwift/server/IndexHandler.swift.vmg
 */

import PerfectLib

class IndexHandler: PageHandler { 

 func valuesForResponse(context: MustacheEvaluationContext, collector: MustacheEvaluationOutputCollector) throws -> MustacheEvaluationContext.MapType {
		
		var values = [String:Any]()
		
		if let acceptStr = context.webRequest?.httpAccept() {
			if acceptStr.contains("json") {
				values["json"] = true
			}
		}
		values["name"] = "PerfectTodoList"
		var routes =  Array<String>()
		
		//Routes for Status
		routes.append("GET /api/status")
		routes.append("POST /api/status")
		routes.append("GET /api/status/{id}")
		routes.append("PUT /api/status/{id}")
		routes.append("POST /api/status/{id}")
		routes.append("DELETE /api/status/{id}")
		//Routes for Task
		routes.append("GET /api/task")
		routes.append("POST /api/task")
		routes.append("GET /api/task/{id}")
		routes.append("PUT /api/task/{id}")
		routes.append("POST /api/task/{id}")
		routes.append("DELETE /api/task/{id}")
		//Routes for TodoItem
		routes.append("GET /api/todoItem")
		routes.append("POST /api/todoItem")
		routes.append("GET /api/todoItem/{id}")
		routes.append("PUT /api/todoItem/{id}")
		routes.append("POST /api/todoItem/{id}")
		routes.append("DELETE /api/todoItem/{id}")

		values["routes"] = routes;
		return values
	}
	
}

/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 13.1 minutes to type the 1310+ characters in this file.
 */
