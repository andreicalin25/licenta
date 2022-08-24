class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :teachers_subjects, dependent: :destroy
  has_many :subjects, through: :teachers_subjects
  has_many :enrollments, dependent: :destroy
  has_many :question_likes, dependent: :destroy
  has_many :answer_likes, dependent: :destroy

  # validates :email, presence: true
  validates_format_of :email,:with => Devise::email_regexp
  validates :last_name, length: { minimum: 2 }
  validates :first_name, length: { minimum: 2 }

  validates :role, inclusion: { in: %w(ADMIN TEACHER STUDENT),
                                message: "%{value} must be STUDENT or TEACHER" }, allow_nil: false


  scope :teachers, -> {where(role: "TEACHER")}
  scope :students, -> {where(role: "STUDENT")}
  scope :active, -> {where(activated: true)}
  scope :inactive, -> {where(activated: false)}

  def self.most_active_students(teachers_subject)
    # iau fiecare pereche de [question_id, user_id], aplic distinct pe ea (adica vad fiecare user la ce intrebari a raspuns, nu si de cate ori)
    # iau doar id-urile (o sa am o lista cu id-ri care se repeta, fiecare repetitie find o intrebare la care a dat raspuns),
    # aplic tally (numar de cate ori apare id-ul), sortez descrescator
    # => [[3, 6], [2, 3], [8, 1], [5, 1]]
    answers = Answer.all
    if teachers_subject != nil
      answers = Answer.of_teachers_subject(teachers_subject)
    end

    list = answers.where(anonymous: false).pluck(:question_id, :user_id).uniq.map{|pair| pair.second}.tally.sort_by{|k, v| v}.reverse
    list_of_students = []

    list.each do |pair|
      user = self.find(pair.first)
      nr = pair.second

      if user.role == 'STUDENT'
        list_of_students.append([user, nr])
      end
    end

    list_of_students
  end

  def self.most_appreciated_students(teachers_subject)
    answers = Answer.all
    if teachers_subject != nil
      answers = Answer.of_teachers_subject(teachers_subject)
    end

    list = answers.pluck(:user_id, :answer_likes_count).each_with_object({}) { |(k, v), res| res[k] ||= 0; res[k] += v }.to_a.sort_by{|k, v| v}.reverse
    list_of_students = []

    list.each do |pair|
      user = self.find(pair.first)
      nr = pair.second

      if user.role == 'STUDENT'
        list_of_students.append([user, nr])
      end
    end

    list_of_students
  end
end
