![Generatron](https://www.generatron.com/logosmall.png)

Engineered with [Kitura-REST](https://www.generatron.com/#/generatron/Kitura-REST)

#TodoList


## Installing and Running

1. Database

  1. Create a MySQL database named TodoList
  
  2. run script under mysql/createTablesMySQL.sql 

2. Build TodoList application

  1. Mac OS X: 
	
	`swift build -Xcc -fblocks -Xswiftc -I/usr/local/include -Xswiftc -I/usr/local/mysql/include -Xlinker -L/usr/local/lib -Xlinker -L/usr/local/mysql/lib`
     
     Xcode
     Open project and ad libmysqlclient.a to MySQL target, 'Link with Binaries'
     
  2. Linux:
  
    `swift build -Xcc -fblocks`
	
3. Run the TodoList application:

	`./.build/debug/TodoList`
	
4. Open up your browser, and view: 

   [http://localhost:9000](http://localhost:9000)

5. Generate a project file for  TodoList application
swift build --generate-xcodeproj .

## Tests

  To run unit tests, run:
  
  `swift test`

## Links

   
   [Kitura ](https://github.com/IBM-Swift/Kitura)
   
   [Kitura TodoList Sample](https://github.com/IBM-Swift/Kitura-TodoList)
   
   [Swift](https://swift.org/)
   
 