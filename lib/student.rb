class Student
  attr_reader(:student_name, :student_id)


  define_method(:initialize) do |attributes|
    @student_name = attributes.fetch(:student_name)
    @student_id = attributes.fetch(:student_id)
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO students (student_name) VALUES ('#{@student_name}') RETURNING student_id")
    @student_id = result.first().fetch("student_id").to_i()
  end

  define_singleton_method(:all) do
      returned_students = DB.exec("SELECT * FROM students")
      students = []
      returned_students.each() do |student|
        student_name = student.fetch("student_name")
        student_id = student.fetch("student_id").to_i()
        students.push(Student.new({:student_name => student_name, :student_id => student_id}))
      end
      students
  end

  define_method(:==) do |another_student|
    self.student_name().==(another_student.student_name()).&(self.student_id().==(another_student.student_id()))
  end
end
