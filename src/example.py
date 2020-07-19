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

import glob

def speak(text):
    print(text)
    return text

def listDb():
    listFilesDb = glob.glob("../assets/db/*.rings")    
    text = listFilesDb[0]
    print(text)
    return text

