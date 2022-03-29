import argparse


default_input_path = './test.log'



def parse_args():
    parser = argparse.ArgumentParser(description='Statistics for x&y of one file')
    parser.add_argument( '-i', '--input', type=str, default=default_input_path,
        help='The input file for testing. Default: ./test.log')

    args = parser.parse_args()
    return args


def main():
    args = parse_args()
    with open(args.input, 'r', encoding='utf-8') as file:
        lines = file.read()
    
    lines = lines.replace('\r','').replace('\n\n', '\n').split('\n')[:-1]
    # print(lines)
    lines_number = len(lines)
    print('totally read %d lines.' % lines_number)

    judge_table = {}
    judge_table['x=0'] = 0
    judge_table['x=1'] = 2
    judge_table['y=0'] = 0
    judge_table['y=1'] = 1
    x_flag = False
    y_flag = False
    result_table = ['x=0, y=0', 'x=0, y=1', 'x=1, y=0', 'x=1, y=1', 'invalid']
    result_count = [0, 0, 0, 0, 0]
    correct_count = 0


    current_line_index = 0
    while current_line_index < lines_number:
        x_flag = False
        y_flag = False
        result_type = 0
        for index_tail in range(2):
            line_invalid_flag = False
            tmp_line_index = current_line_index + index_tail
            tmp_line = lines[tmp_line_index]
            # print(tmp_line)
            if tmp_line == 'x=0' or tmp_line == 'x=1':
                x_flag = True
            elif tmp_line == 'y=0' or tmp_line == 'y=1':
                y_flag = True
            else:
                line_invalid_flag = True
            if not line_invalid_flag:
                result_type = result_type + judge_table[tmp_line]
        
        if not(x_flag and y_flag):
            result_type = 4
        else:
            correct_count += 1
        result_count[result_type] += 1

        current_line_index = current_line_index + 2

    for type_index in range(4):
        print('Type: {}:\n    In total {} case(s). {}%'.format(result_table[type_index], result_count[type_index], result_count[type_index]*100 / correct_count ) )
    print('Type: {}:\n    In total {} case(s).'.format(result_table[4], result_count[4]) )
    pass 



if __name__ == '__main__':
    main()
    pass