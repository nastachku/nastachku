class TicketCodeGenerator
  class << self
    def generate(params)
      Array.new(params[:count].to_i) do
        {
          category: params[:category],
          propagator_id: params[:propagator_id],
          code: generate_code(params[:category], params[:propagator_id])
        }
      end
    end

    private
    def generate_code(category, propagator_id)
      random_string = SecureRandom.hex(3)

      "#{category_code(category)}#{propagator_id}#{random_string}"
    end

    def category_code(category)
      {
        listener: 0,
        student: 1,
        organizer: 2,
        sponsor: 3,
        vip: 4,
        speaker: 5,
        participant: 7,
        media: 8,
        volunteer: 9
      }[category.to_sym]
    end
  end
end
