require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/course")
require("./lib/student")
require("./lib/department")
require("pg")

DB = PG.connect({:dbname => "registrar"})

get("/") do
  @courses = Course.all()
  @students = Student.all()
  @departments = Department.all()
  erb(:index)
end

post("/courses") do
  course_name = params.fetch("course_name")
  course_id = params.fetch("course_id")
  course = Course.new({:course_name => name, :course_id => nil})
  course.save()
  @courses = Course.all()
  erb(:index)
end

post("/students") do
  student_name = params.fetch("student_name")
  student_id = params.fetch("student_id")
  student = Student.new({:student_name => student_name, :student_id => nil})
  student.save()
  @students = Student.all()
  erb(:index)
end

post("/departments") do
  department_courses = params.fetch("department_courses")
  department_students = params.fetch("department_students")
  department = Department.new({:department_courses => department_courses, :department_students => nil})
  department.save()
  @departments = Department.all()
  erb(:index)

end
