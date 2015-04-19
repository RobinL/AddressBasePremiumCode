
# coding: utf-8

# In[153]:

my_dir = r"F:\Shapefiles\ab_premium\processed_csvs"
files_list = [ r'ID10_Header_Records.csv',
 r'ID11_Street_Records.csv',
 r'ID15_StreetDesc_Records.csv',
 r'ID21_BLPU_Records.csv',
 r'ID23_XREF_Records.csv',
 r'ID24_LPI_Records.csv',
 r'ID28_DPA_Records.csv',
 r'ID29_Metadata_Records.csv',
 r'ID30_Successor_Records.csv',
 r'ID31_Org_Records.csv',
 r'ID32_Class_Records.csv',
 r'ID99_Trailer_Records.csv']


# In[154]:

import os
for fname_str in files_list:
    path_str = os.path.join(my_dir,fname_str)

    with open(path_str,"r+b") as my_file:

        #Move the pointer (similar to a cursor in a text editor) to the end of the file. 
        my_file.seek(0, os.SEEK_END) 

        #The end of the file is the position after the final char - this goes to before the final char
        pos = my_file.tell() -1
        my_file.seek(pos, os.SEEK_SET)

        last_char = my_file.read(1) 
        if last_char == "\n": 
            my_file.seek(pos, os.SEEK_SET)
            my_file.truncate()
        if last_char == "\r": 
            my_file.seek(pos, os.SEEK_SET)
            my_file.truncate()

        #Move the pointer (similar to a cursor in a text editor) to the end of the file. 
        my_file.seek(0, os.SEEK_END) 

        #The end of the file is the position after the final char - this goes to before the final char
        pos = my_file.tell() -1
        my_file.seek(pos, os.SEEK_SET)

        last_char = my_file.read(1) 
        if last_char == "\n": 
            my_file.seek(pos, os.SEEK_SET)
            my_file.truncate()
        if last_char == "\r": 
            my_file.seek(pos, os.SEEK_SET)
            my_file.truncate()

