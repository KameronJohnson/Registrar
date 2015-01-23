class Department
  attr_reader(:department_students, :department_courses)


  define_method(:initialize) do |attributes|
    @department_students = attributes.fetch(:department_students)
    @department_courses = attributes.fetch(:department_courses)
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO departments (department_students) VALUES ('#{@department_students}') RETURNING department_courses")
    @department_courses = result.first().fetch("department_courses").to_i()
  end

  define_singleton_method(:all) do
      returned_departments = DB.exec("SELECT * FROM departments")
      departments = []
      returned_departments.each() do |department|
        department_students = department.fetch("department_students")
        department_courses = department.fetch("department_courses").to_i()
        departments.push(Department.new({:department_students => department_students, :department_courses => department_courses}))
      end
      departments
  end

  define_singleton_method(:department_find) do |id|
    found_department = nil
    Department.all().each() do |department|
      if department.department_courses().==(id)
        found_department = department
      end
    end
    found_department
  end

  define_method(:departments) do
    list_departments = []
    departments = DB.exec("SELECT * FROM departments WHERE department_courses = #{self.department_courses()};") &
                  DB.exec("SELECT * FROM departments WHERE department_students = #{self.department_students()};")
    list_departments.each() do |department|
      department_students = department.fetch("department_students")
      department_courses = department.fetch("department_courses")
      list_departments.push(Department.new({:department_students => department_students, :department_courses => department_courses}))
    end
    list_departments
  end

  define_method(:==) do |another_department|
    self.department_students().==(another_department.department_students()).&(self.department_courses().==(another_department.department_courses()))
  end
end
