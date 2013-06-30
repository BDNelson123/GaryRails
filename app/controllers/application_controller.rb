class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def paginationTotal(model)
    @total = model.count(:all)
  end

  private
  def paginationPage(page)
    if page == nil or page < '1' or page == ''
      @page = '1'
    else
      @page = page
    end
  end

  private
  def paginationOrder(model, order)
    if order == nil
      if model == Client
        @order = "lastname ASC"
      else
        @order = "id DESC"
      end
    else
      @order = order
    end
  end

  private
  def paginationPerPage(perPage)
    if (perPage != '15' and perPage != '25' and perPage != '50' and perPage != '100') or perPage == nil
      @perPage = '15'
    else
      @perPage = perPage
    end
  end

  protected
  def pagination(model, page, perPage, order)
    paginationTotal(model)
    paginationPage(page)
    paginationOrder(model, order)
    paginationPerPage(perPage)

    # find total pages
    @totalPages = (@total.to_f / @perPage.to_f).ceil

    if Integer(@page) > Integer(@totalPages)
      @page = @totalPages
    end

    # find beginning of each page
    if Integer(@perPage) > Integer(@total) or Integer(@page) == 1
      @beginning = 0
    else
      @beginning = (Integer(@page) * Integer(@perPage)) - Integer(@perPage)
    end

    # sql query
    model.find(:all, :limit => @perPage, :offset => @beginning, :order => @order)
  end
end
