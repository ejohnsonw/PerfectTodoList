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
Filename:     TaskRepositoryMySQL.swift
Description:  Persistence code for for Task
Project:      TodoList
Template: persistenceManagerSwift/EntityRepositoryMySQL.swift.vm
 */

import MySQL


class TaskRepositoryMySQL : RepositoryMySQL , TaskRepository {

func insert(entity: Task) throws -> Int {
       	let sql = "INSERT INTO Task(`completed`,`order`,`title`,`todo_id`) VALUES ( ?, ?, ?, ?)"
       	
       	let statement = MySQLStmt(db)
		defer {
			statement.close()
		}
		let prepRes = statement.prepare(sql)
		if(prepRes){

		if(entity.completed != nil){
			if(entity.completed == true){
				statement.bindParam(Int(1))
			}else{
				statement.bindParam(Int(0))
			}
		}else{
			statement.bindParam()
		}

		

		if(entity.order != nil){
			statement.bindParam(entity.order)
		}else{
			statement.bindParam()
		}

		

		if(entity.title != nil){
			statement.bindParam(entity.title)
		}else{
			statement.bindParam()
		}

		

if(entity.todo != nil){
			statement.bindParam(entity.todo.id)
}else{
			statement.bindParam()
}
		
			let execRes = statement.execute()
			if(execRes){
				entity.id = Int(statement.insertId()) ;
				return entity.id
			}else{
				print("\(statement.errorCode()) \(statement.errorMessage()) - \(db.errorCode()) \(db.errorMessage())")
				let errorCode = db.errorCode()
				if errorCode > 0 {
				    throw RepositoryError.Insert(errorCode)
				}
			}
				
			statement.close()
	}        
 	return 0
	}
    
	func update(entity: Task) throws -> Int {
        guard let id = entity.id else {
            return 0
        }
        
        let sql = "UPDATE Task SET `completed` = ? ,`order` = ? ,`title` = ? ,`todo_id` = ? WHERE id = ?"

let statement = MySQLStmt(db)
		defer {
			statement.close()
		}
		let prepRes = statement.prepare(sql)
		
		if(prepRes){		

		if(entity.completed != nil){
			if(entity.completed == true){
				statement.bindParam(Int(1))
			}else{
				statement.bindParam(Int(0))
			}
		}else{
			statement.bindParam()
		}

		

		if(entity.order != nil){
			statement.bindParam(entity.order)
		}else{
			statement.bindParam()
		}

		

		if(entity.title != nil){
			statement.bindParam(entity.title)
		}else{
			statement.bindParam()
		}

		

if(entity.todo != nil){
			statement.bindParam(entity.todo.id)
}else{
			statement.bindParam()
}
		
			statement.bindParam(entity.id)
			let execRes = statement.execute()
			if(!execRes){
				print("\(statement.errorCode()) \(statement.errorMessage()) - \(db.errorCode()) \(db.errorMessage())")
				let errorCode = db.errorCode()
				if errorCode > 0 {
				    throw RepositoryError.Update(errorCode)
				}
			}
	
			statement.close()
		}
        
		return 0
    }
    
	func delete(id: Int) throws -> Int {
	
	    let sql = "DELETE FROM task WHERE id = \(id)"
	    let _ = db.query(sql)
	    return id;
	}
    
    func retrieve(id: Int) throws -> Task? {
        let sql = "SELECT `completed`,`id`,`order`,`title`,`todo_id` FROM Task WHERE id = \(id)"
        
		let queryResult = db.query(sql)
		 if(queryResult){
        let results = db.storeResults()!
  		let task = Task()
        while let row = results.next() {
						if(row[0] == "1"){
			   	task.completed = Bool(true);
			}else{
				task.completed = Bool(false);
			}

	task.id = Int(row[1]);
	
	task.order = Int(row[2]);
	
	task.title = String(row[3]);
	
            print(row)
        }
        results.close()
	    return task;
	    }else{
				print(" \(db.errorCode()) \(db.errorMessage())")
				let errorCode = db.errorCode()
				if errorCode > 0 {
				    throw RepositoryError.Retrieve(errorCode)
				}
			}
			return nil;
    }
    
    func list() throws -> [Task]  {
        let sql = "SELECT `completed`,`id`,`order`,`title`,`todo_id` FROM Task "
        
        var entities = [Task]()
         let queryResult = db.query(sql)
        if(queryResult){

		let results = db.storeResults()!
  
        while let row = results.next() {
        	let task = Task()
						if(row[0] == "1"){
			   	task.completed = Bool(true);
			}else{
				task.completed = Bool(false);
			}

	task.id = Int(row[1]);
	
	task.order = Int(row[2]);
	
	task.title = String(row[3]);
	
			entities.append(task)
            print(row)
        }
        results.close()
        return entities
			}else{
				print(" \(db.errorCode()) \(db.errorMessage())")
				let errorCode = db.errorCode()
				if errorCode > 0 {
				    throw RepositoryError.List(errorCode)
				}
				return [];
			}
			
    }
}
/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 44.49 minutes to type the 4449+ characters in this file.
 */
