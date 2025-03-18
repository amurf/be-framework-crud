class Todo
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :id, :integer
  attribute :title, :string
  attribute :completed, :boolean, default: false
  attribute :created_at, :datetime

  validates :title, presence: true

  # In-memory storage
  @@todos = []
  @@next_id = 1

  def self.all
    @@todos
  end

  def self.find(id)
    @@todos.find { |todo| todo.id == id.to_i }
  end

  def save
    return false unless valid?

    if id.nil?
      self.id = @@next_id
      @@next_id += 1
      self.created_at = Time.current
      @@todos << self
    else
      existing_todo = self.class.find(id)
      return false unless existing_todo
      existing_todo.attributes = attributes
    end
    true
  end

  def destroy
    if todo = self.class.find(id)
      @@todos.delete(todo)
      true
    else
      false
    end
  end

  def as_json(*)
    {
      id: id,
      title: title,
      completed: completed,
      created_at: created_at&.iso8601
    }
  end
end
