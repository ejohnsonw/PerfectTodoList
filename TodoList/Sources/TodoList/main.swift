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
Filename:     main.swift
Description:  Swift Server
Project:      TodoList
Template: /Kitura-REST/server/main.swift.vmg
 */
import KituraSys
import KituraNet
import Kitura

import LoggerAPI
import HeliumLogger

#if os(Linux)
    import Glibc
#endif

import Foundation

enum TodoListErrors: ErrorProtocol {
    case NoDataForJSON
}

let persistenceManager = PersistenceManagerMySQL();

TodoListRouter.sharedInstance.setupRoutes();
 
#if os(OSX) // Mustache implemented for OSX only yet

#endif

let server = HttpServer.listen(Config.sharedInstance.serverPort,delegate: TodoListRouter.sharedInstance)
print("Server up and running on http://localhost:\(Config.sharedInstance.serverPort)/api/")
Server.run()
/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 6.06 minutes to type the 606+ characters in this file.
 */
