from flask import Flask, render_template, request,jsonify
import pandas as pd
import mysql.connector
import math
import db_class

app = Flask(__name__)

# MySQL database configuration
my_db_connect = db_class.mysql_connector("localhost", "root", "password", "nptel_management")
# Function to insert data into MySQL database
def insert_into_mysql(data):
    insert = my_db_connect.many_std(data)
    if insert:
        print ('inserted succeful')
    else:
        print('ERROR plases check')
@app.route('/')
def index():
    return render_template('index.html')

@app.route('/upload', methods=['POST'])
def upload_file():
    if request.method == 'POST':
        print('inside upload folder')
        print(request.form)
        file = request.files['file']
        sem = request.form['semester']
        year = request.form['year']
        print(type(sem),type(year))

        # Check if the file is of the allowed type
        if file.filename.endswith('.xlsx') or file.filename.endswith('.xls'):
            # Read the Excel file
            df = pd.read_excel(file)
            df_values = df.values
            df_values = df_values[:, :-1].tolist()

            counter = 1
            for values in df_values:
                if math.isnan(values[0]):
                    print('broke',values)
                    break
                else:
                    print(values[0],counter)
                    counter+=1

            df_values = df_values[:counter-1]
            # Insert data into MySQL database
            if True:
                my_db_connect.facade_insert(df_values,sem,year)
                print('succesfullll')
                # If insertion successful, return the inserted data
                inserted_values = df.to_html()
                return render_template('succesful.html')
            else:
                return "Error inserting data into database."
        else:
            return "Unsupported file format. Please upload a .xlsx or .xls file."


@app.route('/succesful_excel')
def success_excel():
    return render_template('succesful.html')


@app.route('/test3',methods=['GET','POST'])
def general_statistics():
    if request.method == "GET":
        course = 'UITOL91'
        set_courses = my_db_connect.all_set_course()
        score_count = my_db_connect.tot_avg_max(course)[0]  # Example: (Total Students, Average Marks, Maximum Marks)
        enrollment_graph = my_db_connect.enrollment_graph(course)  # Example: (Year, Enrollment Count)
        sem_enrollment = my_db_connect.pie_chart(course)  # Example: (Semester, Enrollment Count)
        markshare_50_80 = my_db_connect.getEnrolledCountGroupedByYearAndSemType() # Example: (Course, 0-50%, 50-80%, 80-100%)
        markshare_80_100 = my_db_connect.gold_score_graph(course)  # Example: (Year, Semester, Average Marks)
        toppers_data = my_db_connect.toppers(course)

        #real data 
        acc_year = my_db_connect.getDistinctAcademicYears()
        sem_type = my_db_connect.getDistinctSemesterTypes()

        context = {
            'acc_year': acc_year,
            'sem_type': sem_type
        }
        return render_template('general_statistics.html', set_courses=set_courses, available_courses=set_courses,
                            score_count=score_count, enrollment_graph=enrollment_graph, sem_enrollment=sem_enrollment,
                            markshare_50_80=markshare_50_80, markshare_80_100=markshare_80_100,
                                toppers_data=toppers_data,**context)
    elif request.method == "POST":
        course_selected = request.form['course_selected']
        sem_selected = request.form['sem_selected']
        print('!!!!!!')
        print(course_selected)
        print(sem_selected)

        #real data 
        acc_year = my_db_connect.getDistinctAcademicYears()
        sem_type = my_db_connect.getDistinctSemesterTypes()
        enrollment_count = my_db_connect.getUniqueRegnoCountBySemTypeAndYear(course_selected,sem_selected)
        course_count = my_db_connect.getUniqueCourseCodeCountBySemTypeAndYear(course_selected,sem_selected)
        markshare_50_80 = my_db_connect.getEnrolledCountGroupedByYearAndSemType()
        sem_enrollment = my_db_connect.getSemesterWiseCountByYearAndSemType(course_selected,sem_selected)
        toppers_data = my_db_connect.getToppersgivenSemandYear(sem_selected,course_selected)
        print('ofvotr',toppers_data)
        context = {
            'acc_year': acc_year,
            'sem_type': sem_type,
            'enrollment_count': enrollment_count,
            'course_count': course_count,
            'markshare_50_80': markshare_50_80,
            'sem_enrollment': sem_enrollment,
            'toppers_data': toppers_data
        }
        return render_template('general_statistics.html', **context,post_request=True)
# Sample data (replace with actual data from your database)
# set_courses = [('Course A', "https://courseA.com"), ('Course B',)]
# available_courses = [("Course A", "CS101", 3, "https://courseA.com"), ("Course B", "CS102", 4, "https://courseB.com")]
# score_count = (100, 80, 95)  
# enrollment_graph = [{"year": "2022", "odd_semester": 200, "even_semester": 180},
#                     {"year": "2023", "odd_semester": 250, "even_semester": 230},
#                     {"year": "2024", "odd_semester": 300, "even_semester": 280}]
# sem_enrollment = [("Semester 3", 50), ("Semester 4", 70), ("Semester 5", 80), ("Semester 6", 75), ('Semester 7', 90)]
# markshare_50_80 = [("2022-23", 40, 30), ("2023-24", 50, 20)]
# markshare_80_100 = [("2022-23", 10, 20), ("2023-24", 15, 25)]



# avg_marks_data = [("2022", 3, 80), ("2023", 3, 85), ("2024", 3, 90)]
# toppers_data = [("example1@example.com", 100, 95, "Course A", 5), ("example2@example.com", 98, 90, "Course B", 4)]


@app.route('/course_details', methods=['GET', 'POST'])
def course_stats_final():
    if request.method == "GET":
        course = 'UITOL91'
        set_courses = my_db_connect.all_set_course()
        score_count = my_db_connect.tot_avg_max(course)[0]  # Example: (Total Students, Average Marks, Maximum Marks)
        enrollment_graph = my_db_connect.enrollment_graph(course)  # Example: (Year, Enrollment Count)
        sem_enrollment = my_db_connect.pie_chart(course)  # Example: (Semester, Enrollment Count)
        markshare_50_80 = my_db_connect.silver_score_graph(course) # Example: (Course, 0-50%, 50-80%, 80-100%)
        markshare_80_100 = my_db_connect.gold_score_graph(course)  # Example: (Year, Semester, Average Marks)
        toppers_data = my_db_connect.toppers(course)
        print('available_courses,score_count,enrollment_graph,sem_enrollment,markshare,markshare_80_100,toppers_data')
        print(set_courses,score_count,enrollment_graph,sem_enrollment,markshare_50_80,markshare_80_100,toppers_data)
        return render_template('course_stats_final.html', set_courses=set_courses, available_courses=set_courses,
                            score_count=score_count, enrollment_graph=enrollment_graph, sem_enrollment=sem_enrollment,
                            markshare_50_80=markshare_50_80, markshare_80_100=markshare_80_100,
                                toppers_data=toppers_data)
    elif request.method == "POST":
        course = request.form['course']
        print('!!!!!!')
        print(course)
        set_courses = my_db_connect.all_set_course()
        score_count = my_db_connect.tot_avg_max(course)[0]  # Example: (Total Students, Average Marks, Maximum Marks)
        enrollment_graph = my_db_connect.enrollment_graph(course)  # Example: (Year, Enrollment Count)
        sem_enrollment = my_db_connect.pie_chart(course)  # Example: (Semester, Enrollment Count)
        markshare_50_80 = my_db_connect.silver_score_graph(course) # Example: (Course, 0-50%, 50-80%, 80-100%)
        markshare_80_100 = my_db_connect.gold_score_graph(course)  # Example: (Year, Semester, Average Marks)
        toppers_data = my_db_connect.toppers(course)
        course_data = my_db_connect.course_details(course)[0]
        print('available_courses,score_count,enrollment_graph,sem_enrollment,markshare,markshare_80_100,toppers_data')
        print(set_courses,score_count,enrollment_graph,sem_enrollment,markshare_50_80,markshare_80_100,toppers_data,course_data)

        context = {
            'course_data': course_data,
            'set_courses': set_courses,
            'available_courses': set_courses,
            'score_count': score_count,
            'enrollment_graph': enrollment_graph,
            'sem_enrollment': sem_enrollment,
            'markshare_50_80': markshare_50_80,
            'markshare_80_100': markshare_80_100,
            'toppers_data': toppers_data,
            'course': course,
            'post_request': True
        }
        return render_template('course_stats_final.html', **context)



# Define dummy data
dummy_data = {
    'course_distribution': {
        'Math': 30,
        'Science': 20,
        'History': 15,
        'English': 25,
        'Art': 10
    },
    'marks_distribution': {
        '0-25': 10,
        '26-50': 20,
        '51-75': 30,
        '76-100': 40
    },
    'student_data': {
        '2021-22': {
            'ODD': {
                'total_students': 100,
                'total_courses': 5,
                'top_10_scores': [95, 92, 89, 85, 82, 80, 78, 75, 72, 70]
            },
            'EVEN': {
                'total_students': 110,
                'total_courses': 6,
                'top_10_scores': [98, 95, 93, 90, 88, 85, 83, 80, 78, 75]
            }
        },
        '2022-23': {
            'ODD': {
                'total_students': 105,
                'total_courses': 5,
                'top_10_scores': [97, 94, 91, 88, 85, 82, 80, 78, 76, 74]
            },
            'EVEN': {
                'total_students': 115,
                'total_courses': 6,
                'top_10_scores': [99, 96, 94, 91, 88, 86, 84, 81, 79, 76]
            }
        },
        '2023-24': {
            'ODD': {
                'total_students': 110,
                'total_courses': 5,
                'top_10_scores': [98, 95, 92, 89, 86, 83, 80, 78, 76, 74]
            },
            'EVEN': {
                'total_students': 120,
                'total_courses': 6,
                'top_10_scores': [100, 97, 95, 92, 90, 88, 86, 83, 80, 78]
            }
        }
    }
}

@app.route('/test2')
def sa():
    academic_years = ['2021-22', '2022-23', '2023-24']
    semesters = ['ODD', 'EVEN']
    return render_template('overall_stats.html', academic_years=academic_years, semesters=semesters)

@app.route('/fetch_data', methods=['POST'])
def fetch_data():
    year = request.form['academic_year']
    semester = request.form['semester']
    print('year,semester')
    print(year,semester)
    if year in dummy_data['student_data'] and semester in dummy_data['student_data'][year]:
        data = dummy_data['student_data'][year][semester]
        return jsonify(data)
    else:
        return jsonify(dummy_data)  # Return course and marks distribution if student data not found



if __name__ == '__main__':
    app.run(debug=True)
