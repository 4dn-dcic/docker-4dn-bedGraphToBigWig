import sys
import click


@click.command()
@click.argument('file')
@click.argument('chromsizes')
def main(file, chromsizes):

    # Getting the files
    chromsizes_file = open(chromsizes).read()
    # Get column 1 of the chromsizes file

    chromsizes_list = chromsizes_file.split('\n')
    chromsizes_data = [i.split('\t') for i in chromsizes_list]
    chromsizes_names = []
    for item in chromsizes_data:
        ele = item[0]
        chromsizes_names.append(ele)

    # Function that checks if the file is formatted properly
    def check_bg_line(line, chromnames):
        missing_values = False
        pass_check = True
        same_chromnames = True
        error = 'okay'

        ele_in_line = line.split('\t')
        ele1 = ele_in_line[0]

        if len(ele_in_line) < 4:
            missing_values = True
            pass_check = False
            if ele1 not in chromnames and ele1 != 'chrM':
                same_chromnames = False
        else:
            if ele1 not in chromnames and ele1 != 'chrM':
                same_chromnames = False
                pass_check = False

        if pass_check is False:
            if missing_values and same_chromnames is False:
                error = "Error: There are missing values and chromosome is not in the chromsizes file in line "
            elif missing_values:
                error = "Error: There are missing values in line "
            elif same_chromnames is False:
                error = "Error: chromosome %s is not in the chromsizes file in line " % (ele1)
            return error
        else:
            return error

    # Run the check on the files
    n_line = 0
    error_list = []
    proper_format = True
    with open(file) as bgfile:
        for line in bgfile:
            n_line += 1
            result = check_bg_line(line, chromsizes_names)

            if result != 'okay':
                proper_format = False
                result += str(n_line)
                if n_line == 1:
                    result += ', please check for header'
                error_list.append(result)

    if proper_format is False:
        print("The file is not formatted properly, the following errors have been found:")
        for err in error_list:
            print(err)
        sys.exit(1)


if __name__ == "__main__":
    main()
