require("spec_helper")



describe(Student) do

  describe(".all") do
    it('is empty at first') do
      expect(Student.all()).to(eq([]))
      end
    end

  describe('#student_name') do
   it('returns the student name') do
    test_student = Student.new(:student_name => "Shim", :student_id => nil)
    expect(test_student.student_name()).to(eq("Shim"))
    end
  end

  describe('#student_id') do
    it ('returns the student id') do
      test_student = Student.new(:student_name => "Shim", :student_id => nil)
      test_student.save()
      expect(test_student.student_id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#save')do
    it('saves each new student to the table in database') do
      test_student = Student.new({:student_name => "Shim", :student_id => nil})
      test_student.save()
      expect(Student.all()).to(eq([test_student]))
    end
  end

    describe("#==") do
      it("is the same student if it has the same student name or student ID") do
        student1 = Student.new({:student_name => "Kam", :student_id => nil})
        student2 = Student.new({:student_name => "Kam", :student_id => nil})
        expect(student1).to(eq(student2))
      end
    end
end
