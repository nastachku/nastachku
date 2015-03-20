class UsersCsvStreamer

  attr_accessor :params

  def initialize(params = {})
    @params = params
  end

  def users
    @users ||= begin
        users = User.all
        users = users.where(@params) if @params.present?
        users
      end
  end

  def filename
    "nastachku_users_#{DateTime.current.utc.strftime("%Y-%m-%d_%H-%M-%S")}.csv"
  end

  def each
    yield csv_header
    users.find_in_batches do |user_chunk|
      user_chunk.each do |user|
        yield csv_record(user)
      end
    end
  end

  private

  def csv_header
    [
      "FirstName",
      "LastName",
      "Email"
    ].to_csv
  end

  def csv_record(user)
    [
      user.first_name,
      user.last_name,
      user.email
    ].to_csv
  end
end
