'''
 Copyright (C) 2020  Frederic SIEBERT

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; version 3.

 rings is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
'''
import blowfish
import glob

def speak(text):
    print(text)
    return text

def speak2(text):
    return text

def listDb():
    #Function for list all db in db directory
    listFilesDb = glob.glob("assets/db/*.rings")
    i=0
    #Get the name of each db
    for myfiles in listFilesDb:
        splitFile = myfiles.split("/")
        nameFile = splitFile[len(splitFile)-1]
        listFilesDb[i] = nameFile.replace(".rings", "")
        i+=1
    #Return the list value to qml
    return listFilesDb 

def encryptDb(userPassword, database):
    #Encrypt the existing password db
    dataBaseName = "assets/db/"+ database + ".rings"
    dbopen = open(dataBaseName, 'r+')
    contentDb = dbopen.readlines()
    encryptContent = b"".join(cipher.encrypt_cbc_cts(contentDb, userPassword))
    dbopen.write(encryptContent)
    dbopen.close()
    return 1

def decryptDb(userPassword, database):
    #Decrypt database with userpassword
    dataBaseName = "assets/db/"+ database + ".rings"
    dbopen = open(dataBaseName, 'r+')
    contentDb = dbopen.readlines()
    decryptContent= b"".join(cipher.decrypt_cbc_cts(contentDb, userPassword))
    dbopen.close()
    return decryptContent 

