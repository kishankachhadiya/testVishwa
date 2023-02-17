class ProfileDatatable

  include Pagy::Backend
  delegate :content_tag, :params, :date_format, :link_to, to: :@view

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
    @user.map do |user|
      [
        # content_tag(:tr) do
        #   content = image_tag(job.image, :width => '50', :height => '50' ,class: 'rounded-circle mr-3') if job.image.present?
        #   content&.html_safe
        # end,
        # content_tag(:tr) do
        #   content = user.firstname
        #   content.html_safe
        # end,
        user.firstname,
        user.lastname,
        user.usertype,
        # user.price,


        content_tag(:tr) do
        #   content = '<li>'
        #   content +=link_to "Create", new_sellers_job_path
        #   content += '</li>'
          content += '<li>'
          content += link_to "Edit", edit_user_registration_path(user.id)
          content += '</li>
        #               <li>'
        #   content += link_to "Remove", sellers_job_path(job.id), method: "delete", onclick: "return confirm('Are you sure you want to delete this Product?')"
        #   content += '</li>'
          content.html_safe
        end,
      # content_tag(:div) do
      #   content = '<div class="dropdown">
      #               <a id="basicTable1MenuInvoker" class="u-icon-sm link-muted" href="#" role="button" aria-haspopup="true" aria-expanded="false"
      #                  data-toggle="dropdown"
      #                  data-offset="8">
      #                 <span class="ti-more">Action</span>
      #               </a>
      #
      #               <div class="dropdown-menu dropdown-menu-right" style="width: 150px;">
      #                 <div class="card border-0 p-3">
      #                   <ul class="list-unstyled mb-0">
      #                     <li class="mb-3">'
      #   content += link_to "Edit", edit_sellers_job_path(job.id), class: "d-block link-dark"
      #   content += '</li>
      #                   <li>'
      #   content += link_to "Remove", sellers_job_path(job.id), method: "delete", onclick: "return confirm('Are you sure you want to delete this Product?')" , class: "d-block link-dark"
      #   content += '</li>
      #                   </ul>
      #                 </div>
      #               </div>
      #             </div>'
      #   content.html_safe
      # end
      ]
    end

  end

  def user
    @user ||= fetch_users
  end

  def fetch_users
    user = @options[:recordset]
    if params[:sSearch].present?
      user = user.where(" firstname Ilike :search", search: "#{params[:sSearch]}%")
    end

    if params[:iDisplayLength] == '-1'
      user = user.reorder("#{sort_column} #{sort_direction}")
    else
      @pagy, user = pagy(user.reorder("#{sort_column} #{sort_direction}"), items: per_page, page: page)
    end
    user
  end

  def total_count
    users
    @pagy ? @pagy.count : users.count
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