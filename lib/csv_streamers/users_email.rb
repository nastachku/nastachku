class CsvStreamers::UsersEmail
  attr_accessor :params
  IDENT_FIELD = 2

  def initialize(params = {})
    @report = params[:report]
    @mode = params[:mode]
    @revision = params[:revision]
  end

  def records
    @records ||= begin
        case @mode
        when :archive
          @report.current_revision = @revision
          records = @report.current_fields.dup
        when :full, :resume
          records = User.all
        end
        records
      end
  end

  def filename
    "users_email_#{DateTime.current.utc.strftime("%Y-%m-%d_%H-%M-%S")}.csv"
  end

  def each
    yield csv_header

    processed_fields = []
    records.each do |user|
      user = prepare_fields(user) unless user.kind_of?(Array)

      next if resume_mode? && already_has_field?(user)

      processed_fields.push(user)
      yield user.to_csv.encode('windows-1251')
    end

    if !archive_mode? && processed_fields.any?
      @report.add_new_revision(processed_fields)
      @report.save
    end
  end

  def archive_mode?
    @mode == :archive
  end

  def resume_mode?
    @mode == :resume
  end

  def already_has_field?(user)
    @report.fields.any?{|rev, f|
      f.any? {|u| same_field?(u, user) }
    }
  end

  def same_field?(a, b)
    a[IDENT_FIELD] == b[IDENT_FIELD]
  end

  private

  def csv_header
    [
      "FirstName",
      "LastName",
      "Email"
    ].to_csv
  end

  def prepare_fields(user)
    [
      user.first_name,
      user.last_name,
      user.email
    ]
  end

end
