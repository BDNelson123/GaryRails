class ApplicationController < ActionController::Base
  protect_from_forgery

  # -- Pagination -- #
  private
  def paginationDefaults(model, page, perPage, order)
    if page == nil or page < '1' or page == ''
      @page = '1'
    else 
      @page = page
    end

    if (perPage != '15' and perPage != '25' and perPage != '50' and perPage != '100') or perPage == nil
      @perPage = '15'
    else
      @perPage = perPage
    end

    if order == nil
      if model == Client
        @order = "lastname ASC"
      else
        @order = "id DESC"
      end
    end
  end

  private
  def paginationTotals(model, page, perPage)
    @total = model.count(:all)
    @totalPages = (Integer(@total.to_f) / Integer(@perPage)).ceil

    if Integer(@page) > Integer(@totalPages)
      @page = @totalPages
    end

    if Integer(@perPage) > Integer(@total)
      @perPage = @total
    end

    @beginning = (Integer(@page) * Integer(@perPage)) - (Integer(@perPage) - 1)
  end

  protected
  def pagination(model, page, perPage, order)
    paginationDefaults(model, page, perPage, order)
    paginationTotals(model, page, perPage) 
    model.find(:all, :limit => @perPage, :offset => @beginning, :order => @order)
  end
end
