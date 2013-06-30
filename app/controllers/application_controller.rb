class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def paginationTotal(model, total)
    if total == nil
      @total = model.count(:all)
    else
      @total = total
    end
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
    end
  end

  private 
  def paginationPerPage(perPage)
    if (perPage != '15' and perPage != '25' and perPage != '50' and perPage != '100') or perPage == nil
      @perPage = '15'
    else
      @perpage = perPage
    end
  end

  protected
  def pagination(model, page, perPage, order, total, totalPages)
    paginationTotal(model, total)
    paginationPage(page)
    paginationOrder(model, order)
    paginationPerPage(perPage)

    # find beginning of each page
    if Integer(@perPage) > Integer(@total) or Integer(@page) == 1
      @beginning = 0
    else
      @beginning = (Integer(@page) * Integer(@perPage)) - Integer(@perPage)
    end

    # find total pages
    if totalPages == nil
      @totalPages = (@total.to_f / @perPage.to_f).ceil
    else
      @totalPages = totalPages
    end

    if Integer(@page) > Integer(@totalPages)
      page = @totalPages
    end

    # sql query
    model.find(:all, :limit => @perPage, :offset => @beginning, :order => @order)
  end
end
