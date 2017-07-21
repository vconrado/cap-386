
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
print f
```

    <open file 'file1.txt', mode 'r' at 0x7fb7d03f6270>
    <closed file 'file1.txt', mode 'r' at 0x7fb7d03f6270>


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

f.write('Introduction to Data Science 2!!!')
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
```

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

Reading the Baltimore data of Hot Dogs Vendors:


```python
import csv

fcsv = open('Food_Vendor_Locations.csv','r')
csvreader = csv.DictReader(fcsv)

vendors = []
for row in csvreader:
    vendors.append(row)
fcsv.close()

vendors
```




    [{'Cart_Descr': "Two add'l tables to be added to current 6' table in U shape, with grill & warming pans, Tent",
      'Id': '0',
      'ItemsSold': 'Grilled food, pizza slices, gyro sandwiches',
      'LicenseNum': 'DF000166',
      'Location 1': 'Towson 21204\n(39.28540000000, -76.62260000000)',
      'St': 'MD',
      'VendorAddr': '508 Washington Blvd, confined within 10 x 10 space',
      'VendorName': 'Abdul-Ghani, Christina, "The Bullpen Bar"'},
     {'Cart_Descr': 'Pushcart',
      'Id': '0',
      'ItemsSold': 'Hot Dogs, Sausage, Snacks, Gum, Candies, Drinks',
      'LicenseNum': 'DF000075',
      'Location 1': 'Owings Mill 21117\n(39.29860000000, -76.61280000000)',
      'St': 'MD',
      'VendorAddr': 'SEC Calvert & Madison on Calvert',
      'VendorName': 'Ali, Fathi'},
     {'Cart_Descr': 'Pushcart',
      'Id': '0',
      'ItemsSold': 'Hot dogs, Sausage, drinks, snacks, gum, & candy',
      'LicenseNum': 'DF000133',
      'Location 1': 'Owings Mill 21117\n(39.28920000000, -76.62670000000)',
      'St': 'MD',
      'VendorAddr': 'NEC Baltimore & Pine Sts',
      'VendorName': 'Ali, Fathi'},
     {'Cart_Descr': 'Pushcart',
      'Id': '0',
      'ItemsSold': 'Hot dogs, sausages, chips, snacks, drinks, gum',
      'LicenseNum': 'DF000136',
      'Location 1': 'Owings Mill 21117\n(39.28870000000, -76.61360000000)',
      'St': 'MD',
      'VendorAddr': 'NEC Light & Redwood Sts',
      'VendorName': 'Ali, Fathi'},
     {'Cart_Descr': 'grey pushcart on three wheels',
      'Id': '0',
      'ItemsSold': 'Large & Small beef franks, soft drinks, water, all types of nuts & chips',
      'LicenseNum': 'DF000001',
      'Location 1': 'Baltimore 21239\n(39.27920000000, -76.62200000000)',
      'St': 'MD',
      'VendorAddr': 'On Hamburg St across from the rear end of the Ravens Stadium (Johnny Unitis Plaza). The cart is facing the back parking lots of the baseball stadium. SITE IS NOT TO BE WORKED DURING FOOTBALL GAMES.',
      'VendorName': 'Ali, Yusuf'},
     {'Cart_Descr': 'pushcart with hot/cold running water',
      'Id': '0',
      'ItemsSold': 'Hot dogs, Sodas, Chips',
      'LicenseNum': 'DF000078',
      'Location 1': 'Baltimore 21244\n(39.30250000000, -76.61610000000)',
      'St': 'MD',
      'VendorAddr': 'NWC Charles & Chase Sts',
      'VendorName': 'Amatullah, Maidah'},
     {'Cart_Descr': 'Hot dog cart',
      'Id': '0',
      'ItemsSold': 'Hot dogs, Sausages, Prepackaged snacks, Sodas, Water, Juice, Coffee',
      'LicenseNum': 'DF000068',
      'Location 1': 'Baltimore 21206\n(39.28760000000, -76.61350000000)',
      'St': 'MD',
      'VendorAddr': 'SEC Lombard & Light Sts.',
      'VendorName': 'Amer, Mohamed'},
     {'Cart_Descr': '2 Carts on wheels, 4 tables on wheels',
      'Id': '0',
      'ItemsSold': 'Hot dogs, snacks, coffee and soda',
      'LicenseNum': 'DF000002',
      'Location 1': 'Baltimore 21236\n(39.27520000000, -76.62030000000)',
      'St': 'MD',
      'VendorAddr': 'SW Ostend St & Sharp (Under the bridge)',
      'VendorName': 'Blimline, Lisa'},
     {'Cart_Descr': 'Hot Dog Cart & Grill',
      'Id': '0',
      'ItemsSold': 'Hot Dogs, Burgers, Sausage, Chips, Soda, Water, Pretzels',
      'LicenseNum': 'DF000004',
      'Location 1': 'Baltimore 21217\n(39.28530000000, -76.62270000000)',
      'St': 'MD',
      'VendorAddr': 'SWC Washington & Paca',
      'VendorName': 'Paul & Elizabeth Carter'},
     {'Cart_Descr': 'Hot Dog Cart & Grill',
      'Id': '0',
      'ItemsSold': 'Hot Dogs, Burgers, Sausage, Chips, Soda, Water, Pretzels',
      'LicenseNum': 'DF000005',
      'Location 1': 'Baltimore 21217\n(39.27720000000, -76.62650000000)',
      'St': 'MD',
      'VendorAddr': 'NEC Ostend & Ridgely on Ostend (along fence on E side of Ostend facing lot)',
      'VendorName': 'Paul & Elizabeth Carter'},
     {'Cart_Descr': 'Pushcart & table',
      'Id': '0',
      'ItemsSold': 'Hot dogs, hamburgers, soda, water',
      'LicenseNum': 'DF000007',
      'Location 1': 'Baltimore 21205\n(39.27710000000, -76.62690000000)',
      'St': 'MD',
      'VendorAddr': 'Ridgely & Ostend Sts.',
      'VendorName': 'Ellenberger, Penny'},
     {'Cart_Descr': '3 x 4 table, 2 coolers',
      'Id': '0',
      'ItemsSold': 'Peanuts, Pistachios, Water & Soda',
      'LicenseNum': 'DF000006',
      'Location 1': 'Laurel 20723\n(39.28420000000, -76.61890000000)',
      'St': 'MD',
      'VendorAddr': 'Conway & Howard St. behind Convention Ctr, on Conway',
      'VendorName': 'Wheatley, Lisa'},
     {'Cart_Descr': 'Hot dog cart',
      'Id': '0',
      'ItemsSold': 'Hot dogs, sodas, peanuts & chips',
      'LicenseNum': 'DF000010',
      'Location 1': 'Randallstown 21133\n(39.28530000000, -76.61900000000)',
      'St': 'MD',
      'VendorAddr': 'ES of Howard St near Camden St',
      'VendorName': 'Isreal, David'},
     {'Cart_Descr': 'stainless steel hot dog cart',
      'Id': '0',
      'ItemsSold': 'Hot dogs, chips, sodas',
      'LicenseNum': 'DF000012',
      'Location 1': 'Baltimore 21224\n(39.28860000000, -76.62360000000)',
      'St': 'MD',
      'VendorAddr': 'NEC Redwood/Greene',
      'VendorName': 'Kastanakis, Theodore'},
     {'Cart_Descr': 'Stainless steel hot dog cart',
      'Id': '0',
      'ItemsSold': 'Hot dogs, chips & sodas',
      'LicenseNum': 'DF000014',
      'Location 1': 'Baltimore 21224\n(39.28920000000, -76.62530000000)',
      'St': 'MD',
      'VendorAddr': 'NWC Baltimore & Arch St.',
      'VendorName': 'Kouloumbre, Iaonnis'},
     {'Cart_Descr': 'Stainless steel hot dog cart',
      'Id': '0',
      'ItemsSold': 'Hot dogs, sodas, chips',
      'LicenseNum': 'DF000019',
      'Location 1': 'Baltimore 21224\n(39.29050000000, -76.61400000000)',
      'St': 'MD',
      'VendorAddr': 'NWC of St Paul & Fayette',
      'VendorName': 'Marangos, Toula & Filipos'},
     {'Cart_Descr': 'pushcart - metal cart & dollies',
      'Id': '0',
      'ItemsSold': 'bottled water, soda & gatorade',
      'LicenseNum': 'DF000020',
      'Location 1': 'Baltimore 21212\n(39.28620000000, -76.61910000000)',
      'St': 'MD',
      'VendorAddr': 'SEC Pratt & Howard, next to the Convention Center',
      'VendorName': 'Markiewicz, Robin'},
     {'Cart_Descr': 'stainless steel hot dog cart',
      'Id': '0',
      'ItemsSold': 'Hot dogs, chips, sodas & candy',
      'LicenseNum': 'DF000022',
      'Location 1': 'Baltimore 21237\n(39.28730000000, -76.62500000000)',
      'St': 'MD',
      'VendorAddr': "SS of Baltimore St, approx. 75' west of Green St. on the north side of the University of Md. Hospital Bldg.",
      'VendorName': 'Papastefanou, Stanley'},
     {'Cart_Descr': "wagon, standard 3' x 6' table w/extensions not to exceed 6 ft. high",
      'Id': '0',
      'ItemsSold': 'Hot dogs, sodas & peanuts',
      'LicenseNum': 'DF000026',
      'Location 1': 'Baltimore 21218\n(39.28610000000, -76.61900000000)',
      'St': 'MD',
      'VendorAddr': 'Howard St @ Corner of Convention Center Pratt Sts.',
      'VendorName': 'Rouse, Donald'},
     {'Cart_Descr': "wagon, standard 3' x 6' table w/extensions not to exceed 6 ft. high",
      'Id': '0',
      'ItemsSold': 'Hot dogs, sodas & peanuts',
      'LicenseNum': 'DF000027',
      'Location 1': 'Baltimore 21218\n(39.27650000000, -76.62400000000)',
      'St': 'MD',
      'VendorAddr': 'Corner of 1300 Warner & Ostend St.',
      'VendorName': 'Rouse, Donald'},
     {'Cart_Descr': 'orange pushcart w/totes & wheels for drinks table w/wheels for lemonade & snowballs',
      'Id': '0',
      'ItemsSold': 'nuts & confections, hot dogs,burgers,& tenders, chili,hot & cold sandwiches, chips,nachos & fries, crab/fish cakes, tacos, breakfast sandwiches & pastries, snowballs, hot & cold drinks',
      'LicenseNum': 'DF000032',
      'Location 1': 'Baltimore 21230\n(39.28200000000, -76.62090000000)',
      'St': 'MD',
      'VendorAddr': 'NEC Lee St/400-500 block (between the two poles next to the entrance leading into Camden Yards)',
      'VendorName': 'Shiflett, Roger'},
     {'Cart_Descr': "Plastic cart w/wheels, 3 shelf metal pushcart white table 6' by 3', stainless steel hot dog cart",
      'Id': '0',
      'ItemsSold': 'soda, water, peanuts & hot dogs',
      'LicenseNum': 'DF000034',
      'Location 1': 'Baltimore 21202\n(39.28520000000, -76.62280000000)',
      'St': 'MD',
      'VendorAddr': 'On the island between Paca & Washington Blvd',
      'VendorName': 'Solomon, Damon'},
     {'Cart_Descr': "Plastic cart w/wheels, 3 shelf metal pushcart white table 6' by 3', stainless steel hot dog cart",
      'Id': '0',
      'ItemsSold': 'soda, water, peanuts & hot dogs',
      'LicenseNum': 'DF000035',
      'Location 1': 'Baltimore 21202\n(39.28430000000, -76.61780000000)',
      'St': 'MD',
      'VendorAddr': '200 W Conway & Sharp Sts behind the convention center',
      'VendorName': 'Solomon, Damon'},
     {'Cart_Descr': 'pickup truck',
      'Id': '0',
      'ItemsSold': 'Produce, fruit, vegetables',
      'LicenseNum': 'DF000036',
      'Location 1': 'Baltimore 21201\n(39.29130000000, -76.61200000000)',
      'St': 'MD',
      'VendorAddr': 'NWC Lexington & Davis',
      'VendorName': 'Stansbury, Joseph'},
     {'Cart_Descr': "1-6' table",
      'Id': '0',
      'ItemsSold': 'Peanuts, sodas',
      'LicenseNum': 'DF000037',
      'Location 1': 'Baltimore 21244\n(39.28620000000, -76.61890000000)',
      'St': 'MD',
      'VendorAddr': 'Eastside Howard St/South of Pratt St',
      'VendorName': 'Reid, Gloria'},
     {'Cart_Descr': 'hot dog cart, table',
      'Id': '0',
      'ItemsSold': 'hot dogs, italian sausages, hamburgers, peanuts, pistachios, water & soda',
      'LicenseNum': 'DF000039',
      'Location 1': 'Laurel 20723\n(39.28420000000, -76.61880000000)',
      'St': 'MD',
      'VendorAddr': 'Conway & Howard St behind the Convention Center',
      'VendorName': 'Wheatley, Vinnie'},
     {'Cart_Descr': 'Handcart',
      'Id': '0',
      'ItemsSold': 'hot dogs, peanuts & sodas',
      'LicenseNum': 'DF000041',
      'Location 1': 'Owings Mill 21117\n(39.28640000000, -76.62060000000)',
      'St': 'MD',
      'VendorAddr': 'NEC Eutaw & Pratt Sts.',
      'VendorName': 'Lerman, Abraham'},
     {'Cart_Descr': 'Hot dog cart',
      'Id': '0',
      'ItemsSold': 'Hot dogs, sodas, peanuts, chips, water',
      'LicenseNum': 'DF000043',
      'Location 1': 'Baltimore 21217\n(39.28000000000, -76.62410000000)',
      'St': 'MD',
      'VendorAddr': 'Hamburg & Russell',
      'VendorName': 'Bamba, Youssouf'},
     {'Cart_Descr': 'Pushcart',
      'Id': '0',
      'ItemsSold': 'Beef hot dogs, chicken kabobs, soda, chips',
      'LicenseNum': 'DF000046',
      'Location 1': 'Baltimore 21224\n(39.28950000000, -76.61530000000)',
      'St': 'MD',
      'VendorAddr': 'SWC Charles & Baltimore on Baltimore',
      'VendorName': 'Mazouz, Abdelkarim & Argoum, Mohamed'},
     {'Cart_Descr': '3x6 brown table',
      'Id': '0',
      'ItemsSold': 'Soda, water,peanuts, sunflower seeds',
      'LicenseNum': 'DF000047',
      'Location 1': 'Glen Burnie 21060\n(39.28430000000, -76.61890000000)',
      'St': 'MD',
      'VendorAddr': 'NEC Howard & Conway',
      'VendorName': 'Hynson, Jr., Raymond C.'},
     {'Cart_Descr': 'pushcart',
      'Id': '0',
      'ItemsSold': 'kebab (lamb & Chicken) over rice or sandwich,',
      'LicenseNum': 'DF000049',
      'Location 1': 'Baltimore 21218\n(39.28700000000, -76.61760000000)',
      'St': 'MD',
      'VendorAddr': 'Hopkins Place',
      'VendorName': 'Djelassi, Chaouki'},
     {'Cart_Descr': 'stainless steel hot dog cart',
      'Id': '0',
      'ItemsSold': 'Hot Dogs, Pre-Packaged Snacks, Pre-Packaged Soft Drinks',
      'LicenseNum': 'DF000052',
      'Location 1': 'Middle River 21220\n(39.28870000000, -76.61520000000)',
      'St': 'MD',
      'VendorAddr': 'SWC Charles/Redwood',
      'VendorName': 'K&B Enterprises'},
     {'Cart_Descr': 'Stainless Steel Hot Dog Cart',
      'Id': '0',
      'ItemsSold': 'Gyros, Hot Dogs, Souvlaki & soda',
      'LicenseNum': 'DF000055',
      'Location 1': 'Baltimore 21224\n(39.28730000000, -76.62370000000)',
      'St': 'MD',
      'VendorAddr': 'SWC Greene & Lombard',
      'VendorName': 'Giorgakis, Kalliopi'},
     {'Cart_Descr': 'Pushcart',
      'Id': '0',
      'ItemsSold': 'Hot dogs, Burgers',
      'LicenseNum': 'DF000060',
      'Location 1': 'Baltimore 21216\n(39.29140000000, -76.60890000000)',
      'St': 'MD',
      'VendorAddr': 'NEC Lexington & Gay',
      'VendorName': 'Omar, Khalid'},
     {'Cart_Descr': '2x4 food warmer, grill, food holder, 2 8x8 tables, 10x10 tent',
      'Id': '0',
      'ItemsSold': 'Snowballs, "Pickles Pub" Game Day Menu',
      'LicenseNum': 'DF000063',
      'Location 1': 'Baltimore 21230\n(39.28510000000, -76.62300000000)',
      'St': 'MD',
      'VendorAddr': 'Island between 500 block Washington Blvd.& Russell Street',
      'VendorName': 'Cotton, Eric'},
     {'Cart_Descr': 'trailer/hot dog cart',
      'Id': '0',
      'ItemsSold': 'Hot dogs, sandwiches, pretzels, chips, soda, desserts, water, jucie',
      'LicenseNum': 'DF000065',
      'Location 1': 'Baltimore 21201\n(39.28960000000, -76.61760000000)',
      'St': 'MD',
      'VendorAddr': 'Southside of Baltimore St @ SEC Hanover (near subway entrance) Due to construction in Hopkins Plaza this location is: Temporarily relocated to the NS Baltimore St, extending from the NEC Baltimore & Liberty',
      'VendorName': 'Quint, Brad (The Beef Brothers)'},
     {'Cart_Descr': 'Pushcart',
      'Id': '0',
      'ItemsSold': 'Hot Dogs, Jumbo Hot Dogs, Polish Sausage, Bottled Beverages',
      'LicenseNum': 'DF000066',
      'Location 1': 'Reisterstown 21136\n(39.28500000000, -76.62310000000)',
      'St': 'MD',
      'VendorAddr': 'On the "island" bet. Washington Blvd & Russell St., directly across from "Pickles Pub"',
      'VendorName': 'Kohlhepp, III, Mrs William'},
     {'Cart_Descr': 'Hot Dog Cart',
      'Id': '0',
      'ItemsSold': 'Hot Dogs, Jumbo Hot Dogs, Polish Hot Dogs, Chips, Drinks',
      'LicenseNum': 'DF000067',
      'Location 1': 'Reisterstown 21136\n(39.28430000000, -76.61790000000)',
      'St': 'MD',
      'VendorAddr': 'NWC of Conway & Sharp behind Convention Ctr',
      'VendorName': 'Brewer, Donald Thomas'},
     {'Cart_Descr': 'Table',
      'Id': '0',
      'ItemsSold': 'Hot dogs, soda, nachos, pretzels, Italian sausage',
      'LicenseNum': 'DF000070',
      'Location 1': 'Baltimore 21223\n(39.27720000000, -76.62680000000)',
      'St': 'MD',
      'VendorAddr': 'NWC Ostend @ Ridgely to be on Ostend',
      'VendorName': 'Dunlap, Patricia'},
     {'Cart_Descr': 'pushcart',
      'Id': '0',
      'ItemsSold': 'gyro over rice, chicken over rice,gyro on pita,',
      'LicenseNum': 'DF000076',
      'Location 1': 'Baltimore 21218\n(39.29110000000, -76.61390000000)',
      'St': 'MD',
      'VendorAddr': 'SEC of St. Paul St @ Lexington',
      'VendorName': 'Djelassi, Chaouki'},
     {'Cart_Descr': 'ONE Table',
      'Id': '0',
      'ItemsSold': 'Snacks, Drinks, cotton candy, hot dogs',
      'LicenseNum': 'DF000077',
      'Location 1': 'Baltimore 21236\n(39.28190000000, -76.62030000000)',
      'St': 'MD',
      'VendorAddr': 'NWC Lee/Eutaw',
      'VendorName': 'Blimline, Lisa'},
     {'Cart_Descr': 'ONE Table',
      'Id': '0',
      'ItemsSold': 'Snacks, Drinks, cotton candy, hot dogs',
      'LicenseNum': 'DF000077',
      'Location 1': 'Baltimore 21236\n(39.28500000000, -76.62320000000)',
      'St': 'MD',
      'VendorAddr': 'NWC Lee/Eutaw',
      'VendorName': 'Blimline, Lisa'},
     {'Cart_Descr': 'pushcart & table',
      'Id': '0',
      'ItemsSold': 'Hot dogs, peanuts, sodas, water, chips, snacks',
      'LicenseNum': 'DF000090',
      'Location 1': 'Baltimore 21218\n(39.28550000000, -76.62230000000)',
      'St': 'MD',
      'VendorAddr': 'W. Camden St & Paca St',
      'VendorName': 'Rouse, Nicole'},
     {'Cart_Descr': 'Table & cooler',
      'Id': '0',
      'ItemsSold': 'Peanuts, Soda, Water, Pistachios',
      'LicenseNum': 'DF000092',
      'Location 1': 'Baltimore 21206\n(39.28430000000, -76.61810000000)',
      'St': 'MD',
      'VendorAddr': "20' from the Corner of Conway & Sharp on the Convention Ctr. Side",
      'VendorName': 'Lee, Gary'},
     {'Cart_Descr': 'Pushcart',
      'Id': '0',
      'ItemsSold': 'Mediterranean Rice w/meat, Mediterranean Wrap Sandwiches, Chips, Soda',
      'LicenseNum': 'DF000094',
      'Location 1': 'Windsor Mill 21244\n(39.29030000000, -76.61090000000)',
      'St': 'MD',
      'VendorAddr': 'SE Guilford Ave @ the intersection with E Fayette St to be on Fayette',
      'VendorName': 'Azzouni, Jaafer'},
     {'Cart_Descr': 'Pushcart',
      'Id': '0',
      'ItemsSold': 'Burgers, hot dogs, chawrma, falafel, deli sandwiches, Beverage, coffee',
      'LicenseNum': 'DF000118',
      'Location 1': 'Baltimore 21213\n(39.28780000000, -76.61760000000)',
      'St': 'MD',
      'VendorAddr': 'NEC Hopkins Pl & Lombard to be on North Hopkins Pl.',
      'VendorName': 'Mazouz, Abdelkarim'},
     {'Cart_Descr': 'Pushcart & table',
      'Id': '0',
      'ItemsSold': 'Hot dogs, sausage & meatballs, soda, juice,water, chips, candy, cookies, fresh fruit',
      'LicenseNum': 'DF000124',
      'Location 1': 'Baltimore 21206\n(39.29110000000, -76.61260000000)',
      'St': 'MD',
      'VendorAddr': 'Calvert & Lexington/Courthouse westside',
      'VendorName': 'Stallings, Sha-nel'},
     {'Cart_Descr': 'pushcart',
      'Id': '0',
      'ItemsSold': 'Chicken or lamb over rice, wraps & sandwiches, Hot dogs, breakfast, chips, soda',
      'LicenseNum': 'DF000127',
      'Location 1': 'Windsor Mill 21244\n(39.28820000000, -76.60700000000)',
      'St': 'MD',
      'VendorAddr': 'NWC Market Pl & Lombard, to be on Market, mid-block MUST CLOSE BY 8:00 PM\xc3\xa0HOURS OF OPERATION 7:00AM-8:00PM',
      'VendorName': 'Azzouni, Jaafer'},
     {'Cart_Descr': '2 coolers, pushcart',
      'Id': '0',
      'ItemsSold': 'Assorted nuts, soda, water, Gatorade, cooked food',
      'LicenseNum': 'DF000132',
      'Location 1': 'Baltimore 21212\n(39.28540000000, -76.61900000000)',
      'St': 'MD',
      'VendorAddr': 'NS corner Howard & Camden (in middle of block)',
      'VendorName': 'Roberts, Melvin'},
     {'Cart_Descr': 'pushcart',
      'Id': '0',
      'ItemsSold': 'Grilled hot dogs, burgers, chicken sandwiches, chicken & pork souvlaki, grilled cheese, nachos & cheese, lamb, chops & sandwiches, soda, juice, snacks',
      'LicenseNum': 'DF000135',
      'Location 1': 'Baltimore 21221\n(39.29250000000, -76.61260000000)',
      'St': 'MD',
      'VendorAddr': 'NWC Calvert & Saratoga',
      'VendorName': 'Diakgeorgiou, Euthoxia t/a "Georgey Dee\'s Food Cart"'},
     {'Cart_Descr': 'Pushcart',
      'Id': '0',
      'ItemsSold': 'Hot dogs, chips, candy, bottled water, canned sodas',
      'LicenseNum': 'DF000153',
      'Location 1': 'Baltimore 21239\n(39.29140000000, -76.61040000000)',
      'St': 'MD',
      'VendorAddr': 'NWC Holliday & lexington Sts.',
      'VendorName': 'Winfield, Brian   "Hollywood Dogs"'},
     {'Cart_Descr': 'Hotdog Cart',
      'Id': '0',
      'ItemsSold': 'Hot Dogs, Sodas, Waters, Chips',
      'LicenseNum': 'DF000174',
      'Location 1': 'Pikesville 21208\n(39.28880000000, -76.60810000000)',
      'St': 'MD',
      'VendorAddr': 'NWC Water St & S Frederick St',
      'VendorName': 'Holmes, Robin'},
     {'Cart_Descr': 'table',
      'Id': '0',
      'ItemsSold': 'water, drinks and peanuts',
      'LicenseNum': 'DF000190',
      'Location 1': 'Baltimore 21218\n(39.27930000000, -76.62250000000)',
      'St': 'MD',
      'VendorAddr': 'on Hamburg St between the Stadiums, during baseball  season only',
      'VendorName': 'Rouse, Donald'},
     {'Cart_Descr': 'one table 6x3',
      'Id': '0',
      'ItemsSold': 'Water, peanuts, hot dogs',
      'LicenseNum': 'OF000001',
      'Location 1': 'Baltimore 21224\n(39.27800000000, -76.62620000000)',
      'St': 'MD',
      'VendorAddr': 'SE 700 West St',
      'VendorName': 'Strunk, Kum Cha'},
     {'Cart_Descr': 'one table 6x3',
      'Id': '0',
      'ItemsSold': 'Water & peanuts',
      'LicenseNum': 'OF000002',
      'Location 1': 'Baltimore 21224\n(39.28560000000, -76.62230000000)',
      'St': 'MD',
      'VendorAddr': 'NW W Camden, Washington & Paca',
      'VendorName': 'Strunk, Kum Cha'},
     {'Cart_Descr': 'pushcart',
      'Id': '0',
      'ItemsSold': 'Hot dogs, burgers, subs, soda, chips, water, candy, Chicken',
      'LicenseNum': 'OF000008',
      'Location 1': 'Edgewood 21040\n(39.29850000000, -76.62110000000)',
      'St': 'MD',
      'VendorAddr': '800 Blk. Linden & Madison',
      'VendorName': 'Johnson, Antoine'},
     {'Cart_Descr': 'Mobile Cart Unit',
      'Id': '0',
      'ItemsSold': 'Mexican Food, Sodas, Water, Coffee,Chips',
      'LicenseNum': 'OF000014',
      'Location 1': 'Baltimore 21227\n(39.20270000000, -76.55870000000)',
      'St': 'MD',
      'VendorAddr': '2803 Hawkins Point RD',
      'VendorName': 'Saldana, Maria Teresa Luna'},
     {'Cart_Descr': "6' table & cooler",
      'Id': '0',
      'ItemsSold': 'Water, Soda',
      'LicenseNum': 'OF000015',
      'Location 1': 'Baltimore 21230\n(39.28910000000, -76.62820000000)',
      'St': 'MD',
      'VendorAddr': 'NWC MLK Blvd & W Baltimore',
      'VendorName': 'Canty, Albert'},
     {'Cart_Descr': 'Pushcart',
      'Id': '0',
      'ItemsSold': 'Hot dogs, Chips, Soda',
      'LicenseNum': 'OF000016',
      'Location 1': 'Baltimore 21221\n(39.32840000000, -76.61360000000)',
      'St': 'MD',
      'VendorAddr': '33rd & Calvert Sts.',
      'VendorName': 'Hummel, Gary'},
     {'Cart_Descr': 'Pushcart',
      'Id': '0',
      'ItemsSold': 'Gyro Sandwiches, Hot Dogs, Chips, Sodas',
      'LicenseNum': 'OF000019',
      'Location 1': 'Baltimore 21237\n(39.29860000000, -76.59100000000)',
      'St': 'MD',
      'VendorAddr': 'NEC Wolfe & Monument',
      'VendorName': 'Polychronis, Aristides'},
     {'Cart_Descr': 'Stainless steel hot dog cart',
      'Id': '0',
      'ItemsSold': 'Hot dogs, Chips, Sodas,Cookies, Snowballs, Juice',
      'LicenseNum': 'OF000020',
      'Location 1': 'Baltimore 21213\n(39.29850000000, -76.59210000000)',
      'St': 'MD',
      'VendorAddr': 'NEC Rutland & Monument',
      'VendorName': 'Jarava, Edgar & Gustavo'},
     {'Cart_Descr': 'Stainless steel hot dog cart',
      'Id': '0',
      'ItemsSold': 'Hot dogs, Chips, Sodas, Cookies, Snowballs, Juice',
      'LicenseNum': 'OF000021',
      'Location 1': 'Baltimore 21213\n(39.29640000000, -76.59390000000)',
      'St': 'MD',
      'VendorAddr': 'NEC Broadway & Jefferson St.',
      'VendorName': 'Jarava, Edgar & Gustavo'},
     {'Cart_Descr': 'Stainless steel hot dog cart',
      'Id': '0',
      'ItemsSold': 'Hot dogs, Chips, Sodas, Cookies, Snowballs, Juice',
      'LicenseNum': 'OF000022',
      'Location 1': 'Baltimore 21213\n(39.29730000000, -76.59070000000)',
      'St': 'MD',
      'VendorAddr': 'SEC Wolfe & McElderry Sts.',
      'VendorName': 'Jarava, Edgar & Gustava'},
     {'Cart_Descr': 'Hot dog cart',
      'Id': '0',
      'ItemsSold': 'Hot Dogs, Soda, Chips',
      'LicenseNum': 'OF000023',
      'Location 1': 'Baltimore 21221\n(39.32520000000, -76.62200000000)',
      'St': 'MD',
      'VendorAddr': '3100 Wyman Park Drive',
      'VendorName': 'Hummel, Gary'},
     {'Cart_Descr': 'Pushcart',
      'Id': '0',
      'ItemsSold': 'Hot Dogs, Polish, Potato Chips, Soda, Juice, Cookies and Candy',
      'LicenseNum': 'OF000025',
      'Location 1': 'Baltimore 21213\n(39.29850000000, -76.59190000000)',
      'St': 'MD',
      'VendorAddr': '1800 Blk. of Monument St.',
      'VendorName': 'McCoy, Patrice'},
     {'Cart_Descr': 'Pushcart',
      'Id': '0',
      'ItemsSold': 'Hot dogs, hamburgers, chips, soda',
      'LicenseNum': 'OF000040',
      'Location 1': 'Pasadena 21122\n(39.28890000000, -76.63260000000)',
      'St': 'MD',
      'VendorAddr': '900 Blk. W. Baltimore St, NS of street, middle of blk',
      'VendorName': 'Barr, Nomiki'},
     {'Cart_Descr': 'Handcart',
      'Id': '0',
      'ItemsSold': 'Hot & Cold Beverages, Packaged Snacks, &',
      'LicenseNum': 'OF000043',
      'Location 1': 'Towson 21204\n(39.30720000000, -76.61480000000)',
      'St': 'MD',
      'VendorAddr': 'West Side of the 1600 Block St Paul Street',
      'VendorName': 'Gilliam, Gwendolyn'},
     {'Cart_Descr': 'Pushcart',
      'Id': '0',
      'ItemsSold': 'Hot dogs, chicken, lamb, rice, gyros, chips, soda, water',
      'LicenseNum': 'OF000046',
      'Location 1': 'Baltimore 21211\n(39.30650000000, -76.61770000000)',
      'St': 'MD',
      'VendorAddr': 'SWC Maryland & Oliver',
      'VendorName': 'Elmonir, Elsayed M.'},
     {'Cart_Descr': 'hot dog cart',
      'Id': '0',
      'ItemsSold': 'hot dogs, chili & cheese, popcorn, coffee, tea, hot chocolate, sodas, chips, candy, sodas,',
      'LicenseNum': 'OF000049',
      'Location 1': 'Baltimore 21201\n(39.28560000000, -76.63670000000)',
      'St': 'MD',
      'VendorAddr': 'SWC Pratt & Carrollton',
      'VendorName': 'Lewis, Cynthia'},
     {'Cart_Descr': '2 1/2" x 3 1/2" Compact pushcart',
      'Id': '0',
      'ItemsSold': 'Hot Dogs, Drinks, Snacks, Sausages',
      'LicenseNum': 'OF000050',
      'Location 1': 'Laurel 20707\n(39.29330000000, -76.60780000000)',
      'St': 'MD',
      'VendorAddr': 'NEC Gay & Front',
      'VendorName': 'Parrott, Aaron'},
     {'Cart_Descr': "6' x 3' table",
      'Id': '0',
      'ItemsSold': 'Mango, pineapple, strawberry, melon, cane, avocado, watermelon, coconut',
      'LicenseNum': 'OF000051',
      'Location 1': 'Rosedale 21237\n(39.29980000000, -76.56500000000)',
      'St': 'MD',
      'VendorAddr': '3900 Block of E Monument, north side of street',
      'VendorName': 'Vasquez, Emenegildo " Vasquez Fresh Fruit"'},
     {'Cart_Descr': 'pushcart',
      'Id': '0',
      'ItemsSold': 'hot dogs, chips, cookies, candy, packaged goods, sodas, bottled water',
      'LicenseNum': 'OF000053',
      'Location 1': 'Baltimore 21215\n(39.35320000000, -76.66470000000)',
      'St': 'MD',
      'VendorAddr': 'Belvedere & Lanier',
      'VendorName': 'Johns, Farley'},
     {'Cart_Descr': 'hot dog cart',
      'Id': '0',
      'ItemsSold': 'Hot dogs, Polish sausage, sodas, chips, juices, candy',
      'LicenseNum': 'OF000054',
      'Location 1': 'Baltimore 21224\n(39.28470000000, -76.59320000000)',
      'St': 'MD',
      'VendorAddr': 'NS Fleet, NEC Broadway',
      'VendorName': 'Guzman, Irma  "Irma\'s Best Hot Dogs"'},
     {'Cart_Descr': 'Pushcart',
      'Id': '0',
      'ItemsSold': 'Mediterranean wraps & sandwiches, chicken or beef, over rice, Beverages (water, soda, coffee), chips',
      'LicenseNum': 'OF000055',
      'Location 1': 'Windsor Mill 21244\n(39.33050000000, -76.61490000000)',
      'St': 'MD',
      'VendorAddr': '3500 Blk of N Calvert @ corner of University Pkwy, to be on Calvert',
      'VendorName': 'Azzouni, Jaafer'},
     {'Cart_Descr': 'pushcart',
      'Id': '0',
      'ItemsSold': 'Hot dogs, chips, cookies, soda, water, juice, donuts, bagels, candy',
      'LicenseNum': 'OF000056',
      'Location 1': 'Baltimore 21229\n(39.25990000000, -76.66540000000)',
      'St': 'MD',
      'VendorAddr': 'SWC of Joh & Caton Ave',
      'VendorName': 'Bethea, Anthony "Biggs Food Cart"'},
     {'Cart_Descr': 'Hot Dog Cart & 1 cooler on wheels',
      'Id': '0',
      'ItemsSold': 'Hot Dogs, Snacks, Soda & Water, Candy',
      'LicenseNum': 'OF000060',
      'Location 1': 'Baltimore 21229\n(39.31110000000, -76.60970000000)',
      'St': 'MD',
      'VendorAddr': 'SWC Greenmount & North Ave, to be on North Ave  away from Rite Aid wall',
      'VendorName': 'Brown, April'},
     {'Cart_Descr': 'Pushcart, Cooler on wheels',
      'Id': '0',
      'ItemsSold': 'Hot Dogs, Hamburgers, Chips, Candy, Gum, Soda, Juice',
      'LicenseNum': 'OF000061',
      'Location 1': 'Pikesville 21208\n(39.31440000000, -76.67700000000)',
      'St': 'MD',
      'VendorAddr': '2300 Garrison Blvd, NWC, at the Garwyn Medical Center',
      'VendorName': 'Arlene Gordon'}]



Read about [dialects](https://docs.python.org/2/library/csv.html#dialects-and-formatting-parameters) and [deducing the format of a CSV format](https://docs.python.org/2/library/csv.html#csv.Sniffer).
