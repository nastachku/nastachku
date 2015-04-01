class ReportsCsvStreamer
  def initialize(params = {})
    @streamer_class = "CsvStreamers::#{params[:id].camelize}".safe_constantize
    report = params[:report_id] ? Report.by_kind(params[:id]).find(params[:report_id]) : Report.new(kind: params[:id])

    @params = {
      report: report,
      mode: (params[:mode] || :full).to_sym,
      revision: (params[:revision] || 1).to_i
    }
  end

  def streamer
    @streamer ||= @streamer_class ? @streamer_class.new(@params) : nil
  end
end
