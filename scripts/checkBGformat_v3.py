import sys
import click

@click.command()
@click.argument('file')
@click.argument('chromsizes')


def main(file, chromsizes):
    #Getting the files
    chromsizes_file = open(chromsizes).read()
    #Get column 1 of the chromsizes file

    chromsizes_list = chromsizes_file.split('\n')
    chromsizes_data = [i.split('\t') for i in chromsizes_list]
    chromsizes_names = []
    for item in chromsizes_data:
        ele = item[0]
        chromsizes_names.append(ele)
    #Function that checks if the file is formatted properly

    def run_check_bg(line, chromnames):
        missing_values = False
        pass_check = True
        same_chromnames = True
        error = 'okay'

        ele_in_line = line.split('\t')
        ele1 = ele_in_line[0]

        if len(ele_in_line) < 4:
            missing_values = True
            pass_check = False
            if ele1 not in chromnames:
                same_chromnames = False
        else:
            if ele1 not in chromnames:
                same_chromnames = False
                pass_check = False

        if pass_check == False:
            if missing_values and same_chromnames == False:
                error = "Error: There are missing values and the chromosome name does not match the one in the chromsizes file in line "
            elif missing_values:
                error = "Error: There are missing values in line "
            elif same_chromnames == False:
                error = "Error: The chromosome name does not match the one in the chromsizes file in line "
            return error
        else:
            return error

    # Run the check on the files
    it = 0
    error_list = []
    proper = True
    with open(file) as bgfile:
        for line in bgfile:
            it += 1
            result = run_check_bg(line, chromsizes_names)

            if result is not 'okay':
                proper = False
                result += str(it)
                if it ==1 :
                    result +=', please check for header'
                error_list.append(result)

    if proper == False:
        print("The file is not formatted properly, the following errors have been found:")
        for i in error_list:
            print(i)
        sys.exit(1)
    else:
        print("hello world")

if __name__ == "__main__":
     main()
