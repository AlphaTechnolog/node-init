# Node Init

With this tool you can initialize your node projects more easy

> This tool is writted in bash, because it, it only works in linux

## Installing

To install first clone the repository

```sh
mkdir -p ./repo
cd repo
git clone https://github.com/AlphaTechnolog/node-init node-init
cd node-init
```

Then run the installer:

```sh
sudo ./install.sh
```

Or with make:

```sh
sudo make install
```

## Uninstalling

To uninstall the program you can run the uninstall script:

```sh
sudo ./uninstall.sh
```

Or with make:

```sh
sudo make uninstall
```

## Creating a new node project

The name of the program binary is `ni`, you can create a new project with npm
named `sample-project` with node-init (called `ni` between now):

```sh
ni sample-project
```

It command create a new folder in your pwd named `sample-project` and then it run:

```sh
npm init -y
```

Like the output of the command explain:

```sh
+----------------------------------------------------------------------+                                            [5/5]
| Welcome to node-init                                                 |
|                                                                      |
| > With me you can init more easy your node projects with npm or yarn |
+----------------------------------------------------------------------+
[*] Creating project (sample-project)
  $ mkdir -p sample-project                                                                                              
  $ cd sample-project                                                                                                    
  $ npm init -y                                                                                                          
Wrote to /home/user/sample-project/package.json:                                                                      
                                                            
{                          
  "name": "sample-project",
  "version": "1.0.0",
  "description": "",                                        
  "main": "index.js",         
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"   
  },                 
  "keywords": [],   
  "author": "",      
  "license": "ISC"
}                                                           
                              
                              
  $ cd ..      
[+] Done          
[+] Created the project successfully, execute: $ cd ./sample-project to start using your new node project
```

Then if you run this:

```sh
cd sample-project
ls
```

You will get a list of file in the `sample-project` folder, it's the `package.json`
created with `npm`

## Creating a new node project with yarn

Node init also support yarn, it support npm and yarn, you can create a new project with
yarn, with a command like this:

```sh
ni sample-project yarn
```

> Where the second argument of the command is the dependency manager, like in the help of ni (`ni --help`), it only accept `npm` or `yarn`

It command create a new folder named `sample-project` and then execute in it folder, the next command:

```sh
yarn init -y
```

Like the explanation in the `node-init` output:

```
+----------------------------------------------------------------------+
| Welcome to node-init                                                 |
|                                                                      |
| > With me you can init more easy your node projects with npm or yarn |
+----------------------------------------------------------------------+
[*] Creating project (sample-project)
  $ mkdir -p sample-project
  $ cd sample-project
  $ yarn init -y
yarn init v1.22.17
warning The yes flag has been set. This will automatically answer yes to all questions, which may have security implications.
success Saved package.json
Done in 0.05s.
  $ cd ..
[+] Done
[+] Created the project successfully, execute: $ cd ./sample-project to start using your new node project
```

If you run this command:

```sh
cd sample-project
ls
```

You will get the `package.json` file created by `yarn`

## Creating a project with yarn and npm with dependencies

You can create a project with yarn or npm with dependencies.

To create a project with npm and some dependencies like `uuid`, you can run
a command like this:

```sh
ni sample-project npm uuid
```

And then it create a new folder named `sample-project`, then it run
`npm init -y` and then `npm install uuid`, like in the explanation in
the node-init output:

```
+----------------------------------------------------------------------+
| Welcome to node-init                                                 |
|                                                                      |
| > With me you can init more easy your node projects with npm or yarn |
+----------------------------------------------------------------------+
[*] Creating project (sample-project)
  $ mkdir -p sample-project                                 
  $ cd sample-project                                                                                                      $ npm init -y                                                                                                          
Wrote to /home/user/sample-project/package.json:                                                                      
                                                                                                                         
{                                                           
  "name": "sample-project",                                 
  "version": "1.0.0",
  "description": "",
  "main": "index.js",   
  "scripts": {                                              
    "test": "echo \"Error: no test specified\" && exit 1"
  },                                                                                                                     
  "keywords": [],                                                                                                        
  "author": "",                                                                                                          
  "license": "ISC"                                                                                                       
}
                                                                                                                         
  $ cd ..                                                                                                                
[+] Done                                                                                                                 
[*] Installing dependencies: uuid                                                                                        
  $ cd sample-project                                       
  $ npm install uuid                                        
npm notice created a lockfile as package-lock.json. You should commit this file.                                         
npm WARN sample-project@1.0.0 No description                
npm WARN sample-project@1.0.0 No repository field.          
                              
+ uuid@8.3.2        
added 1 package in 0.35s
  $ cd ..                                                   
[+] Done                                                    
[+] Created the project successfully, execute: $ cd ./sample-project to start using your new node project
```

Then, if you run:

```sh
cd sample-project && ls
```

You can get a list of the files, like this:

```sh
drwxr-xr-x   - user user 28 Dec 12:39  node_modules                                                               
.rw-r--r-- 355 user user 28 Dec 12:39  package-lock.json                                                          
.rw-r--r-- 274 user user 28 Dec 12:39  package.json
```

And if you want to create a project named `sample-project` with yarn and install dependencies
like `express` and `morgan`, you can run the next command:

```sh
ni sample-project yarn express,morgan
```

And then the project will be created like this:

```sh
mkdir -p ./sample-project
cd sample-project
yarn init -y
yarn add express morgan
```

> It commands will be executed by `node-init`

## Creating a new typescript project with express and yarn

To create a new project with typescript you will need the next dependencies:

- express: For make the server
- morgan: To log the requests

Dev dependencies:

- typescript: To type javascript
- @types/node: The types of the node variables
- @types/express: The types for express
- @types/morgan: The types for morgan
- nodemon: For hot reloading server

The typically way to create a project with this features is:

```sh
mkdir -p ./express-ts-project
cd express-ts-project
yarn init -y
yarn add express morgan
yarn add -D @types/node @types/morgan @types/express nodemon typescript
```

Or with npm

```sh
mkdir -p ./express-ts-project
cd express-ts-project
npm init -y
npm install express morgan
npm install -D @types/node @types/morgan @types/express nodemon typescript
```

But you can create it with only **one** command with this tool, like this:

> With yarn:

```sh
ni express-ts-project yarn express,morgan @types/node,@types/morgan,@types/express,nodemon,typescript
```

> With npm

```sh
ni express-ts-project npm express,morgan @types/node,@types/morgan,@types/express,nodemon,typescript
```

And its commands will create the project successfully

## Enjoy

Thank you for read me, and thank you for use `node-init`, if you like this
project, please give me a star :)
