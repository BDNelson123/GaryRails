class ApplicationController < ActionController::Base
  protect_from_forgery

  # -- Pagination -- #
  private
  def paginationDefaults(model, page, perPage, order)
    if page == nil or page < '1' or page == '' or page == 0
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
  def paginationTotals(model)
    @total = model.count(:all)
    @totalPages = (@total.to_f / @perPage.to_f).ceil
  
    if @totalPages < 1
      @totalPages = 1
    end

    if Integer(@page) > Integer(@totalPages)
      @page = @totalPages
    end

    if Integer(@perPage) > Integer(@total)
      @beginning = 1
    else
      @beginning = (Integer(@page) * Integer(@perPage)) - (Integer(@perPage) - 1)
    end
  end

  protected
  def pagination(model, page, perPage, order)
    paginationDefaults(model, page, perPage, order)
    paginationTotals(model) 
    model.find(:all, :limit => @perPage, :offset => @beginning, :order => @order)
  end
end
