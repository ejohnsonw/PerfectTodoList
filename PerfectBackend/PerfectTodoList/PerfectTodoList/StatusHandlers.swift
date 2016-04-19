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
Filename:     StatusHandlers.swift
Description:  Status Handlers for REST endpoints 
Project:      PerfectTodoList
Template: /PerfectSwift/server/entityHandlerClass.swift.vm
 */

import PerfectLib

class StatusListHandler: RequestHandler  {
  
  func handleRequest(request: WebRequest, response: WebResponse) {
  do{
  	let statuss : [Status]  = try PersistenceManagerMySQL.sharedInstance.statusRepository.list()
  	print (NSJSONSerialization.isValidJSONObject (statuss ))
  	
        let json = try Status.encodeList(statuss );
        try response.outputJson(json)
  	}catch{
  	  response.setStatus (500, message: "Could not list Status data")
  	}
    //response.appendBodyString("Index handler: You accessed path \(request.requestURI())")
    response.requestCompletedCallback()
  }
}

class StatusCreateHandler: RequestHandler {
  func handleRequest(request: WebRequest, response: WebResponse) {
     let status = Status() 
     do {
    	try status.decode(request.postBodyString);
    	let result = try PersistenceManagerMySQL.sharedInstance.statusRepository.insert(status)
    	let json = try status.encode()
    	try response.outputJson(json)
    }catch{
        response.appendBodyString("Error accessing data:  \(error)")
    }
    response.requestCompletedCallback()
  }
}

class StatusRetrieveHandler: RequestHandler {
  func handleRequest(request: WebRequest, response: WebResponse) {
   let id = Int(request.urlVariables["id"]!)
    do{
        let status : Status  = try PersistenceManagerMySQL.sharedInstance.statusRepository.retrieve(id!)!
        let json = try status.encode()
        try response.outputJson(json)
    }catch{
        response.setStatus (500, message: "Could not retrieve Status \(id) data")
    }
    response.requestCompletedCallback()
  }
}

class StatusUpdateHandler: RequestHandler {
  func handleRequest(request: WebRequest, response: WebResponse) {
    do {
     	let status = Status() 
    	try status.decode(request.postBodyString);
    	let result = try PersistenceManagerMySQL.sharedInstance.statusRepository.update(status)
    	let json = try status.encode()
    	try response.outputJson(json)
    }catch{
        response.appendBodyString("Error accessing data:  \(error)")
    }
    response.requestCompletedCallback()
  }
}

class StatusDeleteHandler: RequestHandler {
  func handleRequest(request: WebRequest, response: WebResponse) {
    let id = Int(request.urlVariables["id"]!)
    do{
        let result = try PersistenceManagerMySQL.sharedInstance.statusRepository.delete(id!)
        //let json = try status.encode()
        try response.outputJson("{\"id\":\(id),\"message\":\"deleted\"}")
    }catch{
        response.setStatus (500, message: "Could not delete Status \(id) data")
    }
    response.requestCompletedCallback()
  }
}
/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 26.9 minutes to type the 2690+ characters in this file.
 */
