require("spec_helper")


describe(Course) do

  describe(".all") do
    it('is empty at first') do
      expect(Course.all()).to(eq([]))
      end
    end

  describe('#course_name') do
   it('returns the course name') do
    test_course = Course.new(:course_name => "Math 111", :course_id => nil)
    expect(test_course.course_name()).to(eq("Math 111"))
    end
  end

  describe('#course_id') do
    it ('returns the course id') do
      test_course = Course.new(:course_name => "Math 111", :course_id => nil)
      test_course.save()
      expect(test_course.course_id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#save')do
    it('saves each new course to the table in database') do
      test_course = Course.new({:course_name => "Math 111", :course_id => nil})
      test_course.save()
      expect(Course.all()).to(eq([test_course]))
    end
  end

   describe(".course_find") do
    it("returns a list of courses by its course ID number") do
      test_course = Course.new({:course_name => "Writing", :course_id => nil})
      test_course.save()
      test_course2 = Course.new({:course_name => "Math 111", :course_id => nil})
      test_course2.save()
      expect(Course.course_find(test_course2.course_id())).to(eq(test_course2))
    end
  end

  describe("#==") do
    it("is the same course if it has the same course name") do
      course1 = Course.new({:course_name => "Math 111", :course_id => nil})
      course2 = Course.new({:course_name => "Math 111", :course_id => nil})
      expect(course1).to(eq(course2))
    end
  end
end
