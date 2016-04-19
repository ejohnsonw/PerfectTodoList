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
Filename:     Repository.swift
Description:  Base Repository class
Project:      PerfectTodoList
Template: persistenceManagerSwift/Repository.swift.vmg
 */
/*
The MIT License (MIT)

Copyright (c) 2016 Takeo Namba

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
//
//  Repository.swift
//  SwiftBBS
//
//  Created by Takeo Namba on 2016/01/09.
//  Copyright GrooveLab
//

import PerfectLib
import MySQL

enum RepositoryError : ErrorType {
    case Fail(Int)
    case Select(Int)
    case Insert(Int)
    case Update(Int)
    case Delete(Int)
}

class Repository {
    typealias Params = [Any]
    typealias Row = [Any?]
    typealias Rows = [Row]
    typealias MySQLText = [UInt8]
    
    let db: MySQL!
    lazy var nowSql: String = "cast(now() as datetime)"

    init(db: MySQL) {
        self.db = db
    }

    func executeInsertSql(sql: String, params: Params? = nil) throws -> UInt {
        do {
            return try executeSql(sql, params: params) {
                UInt($0.insertId())
            }
        } catch RepositoryError.Fail(let errorCode) {
            throw RepositoryError.Insert(errorCode)
        }
    }
    
    func executeUpdateSql(sql: String, params: Params? = nil) throws -> UInt {
        do {
            return try executeSql(sql, params: params) {
                UInt($0.affectedRows())
            }
        } catch RepositoryError.Fail(let errorCode) {
            throw RepositoryError.Update(errorCode)
        }
    }
    
    func executeDeleteSql(sql: String, params: Params? = nil) throws -> UInt {
        do {
            return try executeSql(sql, params: params) {
                UInt($0.affectedRows())
            }
        } catch RepositoryError.Fail(let errorCode) {
            throw RepositoryError.Delete(errorCode)
        }
    }
    
    func executeSelectSql(sql: String, params: Params? = nil) throws -> Rows {
        do {
            return try executeSql(sql, params: params) { stmt -> Rows in
                let results = stmt.results()
                defer { results.close() }
                
                var rows = Rows()
                if !results.forEachRow({ rows.append($0) }) {
                    throw RepositoryError.Select(Int(stmt.errorCode()))
                }
                return rows
            }
        } catch RepositoryError.Fail(let errorCode) {
            throw RepositoryError.Select(errorCode)
        }
    }

    func stringFromMySQLText(text: MySQLText?) -> String? {
        guard let text = text else { return nil }
        return UTF8Encoding.encode(text)
    }

    func intFromMySQLCount(count: Any?) -> Int {
        if let count = count as? UInt64 {
            //  for linux
            return Int(count)
        } else if let count = count as? Int64 {
            //  for mac
            return Int(count)
        }
        return 0
    }

    private func executeSql<T>(sql: String, params: Params?, @noescape completion: ((MySQLStmt) throws -> T)) throws -> T {
        let stmt = MySQLStmt(db)
        defer { stmt.close() }
        
        if !stmt.prepare(sql) {
            throw RepositoryError.Fail(Int(stmt.errorCode()))
        }
        
        stmt.bindParams(params)
        
        if !stmt.execute() {
            debugPrint(stmt)
            throw RepositoryError.Fail(Int(stmt.errorCode()))
        }
        
        return try completion(stmt)
    }
}
/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 43.49 minutes to type the 4349+ characters in this file.
 */
