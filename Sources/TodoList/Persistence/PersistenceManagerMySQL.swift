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
Filename:     PersistenceManagerMySQL.swift
Description:  MySQL PersistenceManager: an Adapter to deal with persistence layer
Project:      TodoList
Template: persistenceManagerSwift/PersistenceManagerMySQL.swift.vmg
 */

import MySQL

class PersistenceManagerMySQL : PersistenceManager {
	static let sharedInstance = PersistenceManagerMySQL()
    var mysql = MySQL ()
    
    var _statusRepository :  StatusRepositoryMySQL!
    var  statusRepository : StatusRepository! {
    	get {
    	   return _statusRepository;
    	}
    	set {
	        if newValue is StatusRepositoryMySQL {
	            _statusRepository = newValue as! StatusRepositoryMySQL
	        } else {
	            print("incorrect  type for PersistenceManagerMySQL->StatusRepositoryMySQL")
	        }
    	}
    }
    
    var _taskRepository :  TaskRepositoryMySQL!
    var  taskRepository : TaskRepository! {
    	get {
    	   return _taskRepository;
    	}
    	set {
	        if newValue is TaskRepositoryMySQL {
	            _taskRepository = newValue as! TaskRepositoryMySQL
	        } else {
	            print("incorrect  type for PersistenceManagerMySQL->TaskRepositoryMySQL")
	        }
    	}
    }
    
    var _todoItemRepository :  TodoItemRepositoryMySQL!
    var  todoItemRepository : TodoItemRepository! {
    	get {
    	   return _todoItemRepository;
    	}
    	set {
	        if newValue is TodoItemRepositoryMySQL {
	            _todoItemRepository = newValue as! TodoItemRepositoryMySQL
	        } else {
	            print("incorrect  type for PersistenceManagerMySQL->TodoItemRepositoryMySQL")
	        }
    	}
    }
    

    
    func connect() {
    	// Connect to Database.
    	let datasource : GeneratronDataSource = Config.sharedInstance.datasources["mysql"]!
    	do {
        	 let connect = mysql.connect (datasource.host, user:datasource.user, password: datasource.password)
	        if (connect)
	        {
	            let selectedSchema = mysql.selectDatabase (datasource.schema)
	            if (selectedSchema)
	            {
				
				//Variables for Status
				_statusRepository = StatusRepositoryMySQL(db:self.mysql);
				
				//Variables for Task
				_taskRepository = TaskRepositoryMySQL(db:self.mysql);
				
				//Variables for TodoItem
				_todoItemRepository = TodoItemRepositoryMySQL(db:self.mysql);
				}
			}else{
			    throw PersistenceManagerError.Connecting("PROBLEM CONNECTING: \\(datasource.host) \\(datasource.schema) \\(datasource.user)")
			}

    	} catch (let e){
        	print("Failure connecting to MYSQL DB")
        	print(e)
    	}
    	
    }
    
    func checkConnection() -> Bool {
    	let sql = "SELECT 1"
		let queryResult = mysql.query(sql)
		if(!queryResult){
			connect()
		}
		return queryResult
    }
	 func disconnect() throws {
	 }
}

/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 26.6 minutes to type the 2660+ characters in this file.
 */
