class JobsDatatable

  include Pagy::Backend
  delegate :content_tag, :image_tag, :params, :date_format, :new_sellers_job_path, :sellers_job_path, :edit_sellers_job_path, :link_to, to: :@view

  def initialize(view, options = {})
    @view = view
    @options = options
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: @options[:recordset].count,
      iTotalDisplayRecords: total_count,
      aaData: data
    }
  end

  private

  def data
    @jobs.map do |job|
      [
        content_tag(:tr) do
          content = image_tag(job.image, :width => '50', :height => '50', class: 'rounded-circle mr-3') if job.image.present?
          content&.html_safe
        end,

        job.task_title,
        job.price,

        content_tag(:tr) do
          content = '<li>'
          content += link_to "Create", new_sellers_job_path
          content += '</li>'
          content += '<li>'
          content += link_to "Edit", edit_sellers_job_path(job.id)
          content += '</li>
                      <li>'
          content += link_to "Remove", sellers_job_path(job.id), method: "delete", onclick: "return confirm('Are you sure you want to delete this Product?')"
          content += '</li>'
          content.html_safe
        end,

      ]
    end

  end

  def jobs
    @jobs ||= fetch_jobs
  end

  def fetch_jobs
    jobs = @options[:recordset]
    if params[:sSearch].present?
      jobs = jobs.where(" task_title Ilike :search", search: "#{params[:sSearch]}%")
    end

    if params[:iDisplayLength] == '-1'
      jobs = jobs.reorder("#{sort_column} #{sort_direction}")
    else
      @pagy, jobs = pagy(jobs.reorder("#{sort_column} #{sort_direction}"), items: per_page, page: page)
    end
    jobs
  end

  def total_count
    jobs
    @pagy ? @pagy.count : jobs.count
  end

  def page
    params[:iDisplayStart].to_i / per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[created_at name created_at]
    columns[params[:iSortingCols] == "1" ? params[:iSortCol_0].to_i + 1 : 0]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "asc" : "desc"
  end

end