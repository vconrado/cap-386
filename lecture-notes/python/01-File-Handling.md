
# File Handling


File handling in Python requires no importing of modules. 

Python provides the built-in _object file_

Source: https://docs.python.org/2/tutorial/inputoutput.html

## open()

open() returns a file object, and is most commonly used with two arguments: open(filename, mode).
The **mode** indicates, how the file is going to be opened **r** for reading,
**w** for writing and **a** for a appending, **r+** or **w+** from reading and writing, etc. See [fopen](http://www.manpagez.com/man/3/fopen/) for more options.


```python
f = open('file1.txt', 'r')

print f
f.close()
```

    <open file 'file1.txt', mode 'r' at 0x7fe9b4d66ae0>


### Reading a file

To read entire file, use:


```python
f = open('file1.txt', 'r')

print f.read()
f.close()
```

    first line
    second line
    third line
    


To read a block of file's contents, use *read(size)*: 


```python
f = open('file1.txt', 'r')

print f.read(8),
f.close()
```

    first li


To read one line at a time, use:


```python
f = open('file1.txt', 'r')

print f.readline(), 
print f.readline(),
print f.readline(),
f.close()
```

    first line
    second line
    third line


For reading lines from a file, it's possible to loop over the file object:


```python
f = open('file1.txt', 'r')

for line in f:
    print line,  
f.close()
```

    first line
    second line
    third line


To read a list of lines, use:


```python
f = open('file1.txt', 'r')

lines = f.readlines()

print("Total lines: {} \n".format(len(lines)))
for line in lines:
    print line, 
f.close()
```

    Total lines: 3 
    
    first line
    second line
    third line


### Writing to file

To write something to a file, use:


```python
f = open('file2.txt', 'w')

f.write('Introduction to Data Science !!!')
f.close() 
```

To write something other than a string, it needs to be converted to a string first:


```python
value = ['my string', 42, 10+5j, 1./3.0]

f = open('file2.txt', 'w')

s = str(value)
f.write(s)

f.close() 

f = open('file2.txt', 'r')

f.read()
f.close()
```

### File seeking

To change file object's position, use f.seek(offset, from_what). The new position is calculated adding _offset_ to a _from_what_ value. The _from_what_ allowed values are 
 - **0**: the beginning of the file
 - **1**: to the current position 
 - **2**: uses the end of the file 



```python
f = open('file3.txt', 'w+')

f.write('Introduction to Data Science')
f.seek(13)      # Go to the 13th byte
f.read(2)
```




    'to'




```python
f.seek(-7, 2)  # Go to the 7th byte before the end
f.read(7)
```




    'Science'



### close()

Python automatically closes a file when the reference object of a file is reassigned to another file. It is a good practice to use the close() method to close a file.

Read about others ways to use close(): [Is necessary to use close()?](https://stackoverflow.com/a/1832589).

To close a file, use:


```python
f = open('file3.txt', 'w+')
# do something 
f.close()

f
```




    <closed file 'file3.txt', mode 'w+' at 0x7fe9b4d66b70>



To check if a file is closed, use:


```python
f = open('file3.txt', 'w+')
# f.close()

if f.closed:
    print 'File is closed'
else:
    print 'File is opened'
```

    File is opened


### Using with statement

We can use the **with** statement to let Python call a função automatically. A short example:


```python
with open("file1.txt") as f:
    for line in f:
        print line,
```

    first line
    second line
    third line


## CSV Files

There is a python *csv* module that implements classes to read and write tabular data in CSV format. 
Read more about csv module [here](https://docs.python.org/2/library/csv.html).

### Reading a CSV file

Each row read from the csv file is returned as a list of strings. No automatic data type conversion is performed.
A short example:


```python
import csv

fcsv = open('simple.csv', 'r')
csvreader = csv.reader(fcsv)

for row in csvreader:
    print row
fcsv.close()
```

    ['ID', 'Name', 'Age']
    ['1', 'Smith', '11']
    ['2', 'Johnson', '22']
    ['3', 'Williams', '33']


### Writing a CSV File

The writer() function will create an object suitable for writing. To iterate the data over the rows, you will need to use the writerow() function. A short example:


```python
import csv

fcsv = open('simple2.csv', 'w')
csvwriter = csv.writer(fcsv)

csvwriter.writerow(['4','Jones','44'])
fcsv.close()
```

### Loading CSV into dictionary structure

The module **csv** always allows to read row of a csv file into a dictionary structure. See the example:


```python
import csv

fcsv = open('simple.csv','r')
csvreader = csv.DictReader(fcsv)

for row in csvreader:
    print row
fcsv.close()
```

    {'Age': '11', 'ID': '1', 'Name': 'Smith'}
    {'Age': '22', 'ID': '2', 'Name': 'Johnson'}
    {'Age': '33', 'ID': '3', 'Name': 'Williams'}


### Creating a CSV file from a dictionary structure



```python
import csv

fields= ['ID','Age','Name']
users = [
            {'Age': '11', 'ID': '1', 'Name': 'Smith'},
            {'Age': '22', 'ID': '2', 'Name': 'Johnson'},
            {'Age': '33', 'ID': '3', 'Name': 'Williams'}
        ]

fcsv = open('simple3.csv','w')
csvwriter = csv.DictWriter(fcsv, fieldnames=fields)

csvwriter.writeheader()
for user in users:
    csvwriter.writerow(user)

fcsv.close()
```

Read about [dialects](https://docs.python.org/2/library/csv.html#dialects-and-formatting-parameters) and [deducing the format of a CSV format](https://docs.python.org/2/library/csv.html#csv.Sniffer).
