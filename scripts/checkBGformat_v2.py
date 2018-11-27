import sys
import click

@click.command()
@click.argument('bgfile')
@click.argument('chromsizes')


def main(bgfile, chromsizes):
    bgfile = open(bgfile).read()
    chromsizes = open(chromsizes).read()

    #BedGraph format requirements
    pass_check = True
    #header = False
    missing_values = False
    chromnames = True
    #tab-delimited = False


    #Get the files's individual rows
    row_list = bgfile.split('\n')
    #print(row_list)
    len_row_list = len(row_list)
    print(len_row_list)

    #Delete the last row if it is empty
    if row_list[-1] == '':
        row_list = row_list[:len_row_list - 1]
        print(len(row_list))

    #Split into indv elements of each row
    ele_in_row_list = [i.split('\t') for i in row_list ]

    #get the chromosome names in the chromsizes file
    chromsizes_list = chromsizes.split('\n')
    chromsizes_data = [i.split('\t') for i in chromsizes_list]
    chromsizes_names = []
    for item in chromsizes_data:
        ele = item[0]
        chromsizes_names.append(ele)

    #check if the file has a header
    # first_line = ele_in_row_list[0]
    # for item in first_line:

    # we will check each row in the file and look for:
    # a) missing values
    # b) chromosome names matching the ones in the chromsizes files

    column1 = []
    indx = 0
    x = 0

    for row in ele_in_row_list:
        indx = indx + 1
        ele1 = row[0]
        if len(row) < 4:
            missing_values = True
            pass_check = False
        if ele1 not in chromsizes_names:
            chromnames = False
            pass_check = False
        if missing_values or chromnames == False:
            x = x + 1
            if missing_values and chromnames == False:
                print("Error: row " + str(indx) + " is missing a value in one of the columns and the chromosome name does not match the one in the chromsizes file")
            elif missing_values:
                print("Error: row " + str(indx) + " is missing a value in one of the columns")
            elif chromnames == False:
                print("Error: The chromosome name in row " + str(indx) + " does not match the chromosome names in the chromsizes file")

        missing_values = False
        chromnames = True

    if pass_check == False:
        print(str(x) + " rows do not follow the proper bedGraph format")
        sys.exit()
    else:
        print("File  is formatted properly")


if __name__ == "__main__":
     main()
