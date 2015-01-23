require("spec_helper")



describe(Department) do

  describe(".all") do
    it('is empty at first') do
      expect(Department.all()).to(eq([]))
      end
    end

  describe('#department_students') do
   it('returns the department students') do
    test_department = Department.new(:department_students => "Shim", :department_courses => "Math101")
    expect(test_department.department_students()).to(eq("Shim"))
    end
  end

  describe('#department_courses') do
    it ('returns the department courses') do
      test_department = Department.new(:department_students => "Shim", :department_courses => nil)
      test_department.save()
      expect(test_department.department_courses()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#save')do
    it('saves each new department to the table in database') do
      test_department = Department.new({:department_students => "Shim", :department_courses => "Math101"})
      test_department.save()
      expect(Department.all()).to(eq([test_department]))
    end
  end

    describe("#==") do
      it("is the same department if it has the same department students and department courses") do
        department1 = Department.new({:department_students => "Kam", :department_courses => "Math101"})
        department2 = Department.new({:department_students => "Kam", :department_courses => "Math101"})
        expect(department1).to(eq(department2))
      end
    end

    describe(".department_find") do
     it("returns a list of departments by department courses") do
       test_department = Department.new({:department_students => "Kam", :department_courses => "Math101"})
       test_department.save()
       test_department2 = Department.new({:department_students => "Shim", :department_courses => "Math101"})
       test_department2.save()
       expect(Department.department_find(test_department2.department_courses())).to(eq(test_department2))
     end
   end

    describe("#departments") do
    it("returns an array of students and courses for that department") do
      test_department = Department.new({:department_students => "Shim", :department_courses => "Math101"})
      test_department.save()
      test_student = Student.new({:student_name => "Shim", :student_id => test_department.department_students()})
      test_student.save()
      test_course = Course.new({:course_name => "Math101", :course_id => test_department.department_courses()})
      test_department.save()
      expect(test_department.departments()).to(eq([test_student, test_course]))
    end
  end
end
