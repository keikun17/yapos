class ParentCompaniesController < ApplicationController

  def index
    @parent_companies = ParentCompany.page(params[:page]).per_page(40)
    respond_with(@parent_companies)
  end

  def show
    @parent_company = ParentCompany.find(params[:id])
    @quotes = @parent_company.quotes.page(params[:page]).per_page(40)

    respond_with(@parent_company)
  end

  def new
    @parent_company = ParentCompany.new
    respond_with(@parent_company)
  end

  def create
    @parent_company = ParentCompany.new(params[:parent_company])
    @parent_company.save
    respond_with(@parent_company)
  end

end
