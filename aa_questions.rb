require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database         #QuestionsDatabase.new
    include Singleton

    def initialize
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true
    end
end


class User

    attr_accessor :id, :fname, :lname
    
    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def self.find_by_id(id)
        id = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT 
                *
            FROM
                users
            WHERE
                id = ?
        SQL

        return nil if id.length == 0
        User.new(id.first)
    end

    def self.find_by_name(fname, lname)
        full_name = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
            SELECT
                *
            FROM 
                users
            WHERE
                fname = ? AND lname = ?
        SQL

        return nil if full_name.length == 0
        User.new(full_name.first)
    end
end

class Question

    attr_accessor :question_id, :title, :body, :author_id

    def initialize(options)
        @question_id = options['question_id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end

    def self.find_by_id(question_id)
        question_id = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
                *
            FROM
                questions
            WHERE
                question_id = ?
        SQL

        return nil if question_id.length == 0
        Question.new(question_id.first)
    end

end