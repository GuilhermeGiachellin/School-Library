require_relative 'person'

class Student < Person
  attr_reader :classroom

  def initialize(age, name, _parent_permission, classroom: nil)
    super(age, name, parent_permission: true)
    @classroom = classroom
  end

  def play_hook
    "¯\(ツ)/¯"
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end
end
