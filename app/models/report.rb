class Report < ActiveRecord::Base
  attr_accessible :kind
  attr_writer :current_revision

  store :data, accessors: [:fields]

  scope :by_kind, ->(kind) { where(kind: kind) }

  def fields
    super || {}
  end

  def current_fields
    fields.any? ? fields[current_revision] : []
  end

  def add_new_revision(records)
    new_revision = last_revision ? last_revision + 1 : 1
    f = fields.dup
    f[new_revision] = records
    self.fields = f
  end

  def last_revision
    fields.keys.max
  end

  def current_revision
    @current_revision ||= last_revision
  end

  def fields_count
    fields.map{|key, value| value.count}.inject(:+)
  end
end
