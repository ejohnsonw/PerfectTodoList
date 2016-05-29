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
Filename:     TodoItemRepositoryMySQL.swift
Description:  Persistence code for for TodoItem
Project:      TodoList
Template: persistenceManagerSwift/EntityRepositoryMySQL.swift.vm
 */

import MySQL


class TodoItemRepositoryMySQL : RepositoryMySQL , TodoItemRepository {

func insert(entity: TodoItem) throws -> Int {
       	let sql = "INSERT INTO TodoItem(`dueDate`,`notes`,`status_id`,`tasks_id`,`title`) VALUES ( ?, ?, ?, ?, ?)"
       	
       	let statement = MySQLStmt(db)
		defer {
			statement.close()
		}
		let prepRes = statement.prepare(sql)
		if(prepRes){

		if(entity.dueDate != nil){
			statement.bindParam(entity.dueDate.SQLDateString)
		}else{
			statement.bindParam()
		}

		

		if(entity.notes != nil){
			statement.bindParam(entity.notes)
		}else{
			statement.bindParam()
		}

		

if(entity.status != nil){
			statement.bindParam(entity.status.id)
}else{
			statement.bindParam()
}
		

if(entity.tasks != nil){
			statement.bindParam(entity.tasks.id)
}else{
			statement.bindParam()
}
		

		if(entity.title != nil){
			statement.bindParam(entity.title)
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
    
	func update(entity: TodoItem) throws -> Int {
        guard let id = entity.id else {
            return 0
        }
        
        let sql = "UPDATE TodoItem SET `dueDate` = ? ,`notes` = ? ,`status_id` = ? ,`tasks_id` = ? ,`title` = ? WHERE id = ?"

let statement = MySQLStmt(db)
		defer {
			statement.close()
		}
		let prepRes = statement.prepare(sql)
		
		if(prepRes){		

		if(entity.dueDate != nil){
			statement.bindParam(entity.dueDate.SQLDateString)
		}else{
			statement.bindParam()
		}

		

		if(entity.notes != nil){
			statement.bindParam(entity.notes)
		}else{
			statement.bindParam()
		}

		

if(entity.status != nil){
			statement.bindParam(entity.status.id)
}else{
			statement.bindParam()
}
		

if(entity.tasks != nil){
			statement.bindParam(entity.tasks.id)
}else{
			statement.bindParam()
}
		

		if(entity.title != nil){
			statement.bindParam(entity.title)
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
	
	    let sql = "DELETE FROM todoItem WHERE id = \(id)"
	    let _ = db.query(sql)
	    return id;
	}
    
    func retrieve(id: Int) throws -> TodoItem? {
        let sql = "SELECT `dueDate`,`id`,`notes`,`status_id`,`tasks_id`,`title` FROM TodoItem WHERE id = \(id)"
        
		let queryResult = db.query(sql)
		 if(queryResult){
        let results = db.storeResults()!
  		let todoItem = TodoItem()
        while let row = results.next() {
			todoItem.dueDate = (row[0] as String).SQLStringDate();

	todoItem.id = Int(row[1]);
	
	todoItem.notes = String(row[2]);
	
	todoItem.title = String(row[3]);
	
            print(row)
        }
        results.close()
	    return todoItem;
	    }else{
				print(" \(db.errorCode()) \(db.errorMessage())")
				let errorCode = db.errorCode()
				if errorCode > 0 {
				    throw RepositoryError.Retrieve(errorCode)
				}
			}
			return nil;
    }
    
    func list() throws -> [TodoItem]  {
        let sql = "SELECT `dueDate`,`id`,`notes`,`status_id`,`tasks_id`,`title` FROM TodoItem "
        
        var entities = [TodoItem]()
         let queryResult = db.query(sql)
        if(queryResult){

		let results = db.storeResults()!
  
        while let row = results.next() {
        	let todoItem = TodoItem()
			todoItem.dueDate = (row[0] as String).SQLStringDate();

	todoItem.id = Int(row[1]);
	
	todoItem.notes = String(row[2]);
	
	todoItem.title = String(row[3]);
	
			entities.append(todoItem)
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
approximately 45.97 minutes to type the 4597+ characters in this file.
 */
