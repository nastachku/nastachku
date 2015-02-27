class TicketCodeGenerator
  class << self
    def call(params)
      # FIXME сомнительно
      params[:count].times.map do
        {
          category: params[:category],
          kind: params[:kind],
          distributor_id: params[:distributor_id],
          price: params[:price],
          code: generate_code(params[:category], params[:distributor_id])
        }
      end
    end

    private

    def generate_code(category, distributor_id)
      random_string = SecureRandom.hex(3)

      "#{category_code(category)}" +
        ("%03d" % distributor_id) +
        random_string
    end

    def category_code(category)
      TicketCode.categories.fetch category
    end
  end
end
