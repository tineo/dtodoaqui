defmodule DtodoaquiWeb.ReportView do
  use DtodoaquiWeb, :view
  alias DtodoaquiWeb.ReportView

  def render("index.json", %{reports: reports}) do
    %{data: render_many(reports, ReportView, "report.json")}
  end

  def render("show.json", %{report: report}) do
    %{data: render_one(report, ReportView, "report.json")}
  end

  def render("report.json", %{report: report}) do
    %{id: report.id,
      user_id: report.user_id,
      listing_id: report.listing_id,
      message: report.message,
      is_approved: report.is_approved}
  end
end
