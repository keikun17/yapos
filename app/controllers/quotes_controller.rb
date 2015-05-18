class QuotesController < ApplicationController

  before_filter :set_badge_count, only: [:index, :pending_client_po, :pending]

  # GET /quotes
  # GET /quotes.json
  def index
    @quotes = Quote.includes(:requests, :offers, {offers: :supplier_order}, :client, :orders)
    @quotes = filter_quotes_by_params(params).decorate
    respond_with(@quotes)
  end

  # TODO : Change name? the path name is ugly (pending_client_po_quote_path)
  # must be a sign that there is a better name for this out there.
  def pending_client_po
    @quotes = Quote.pending_client_order
    @quotes = filter_quotes_by_params(params).decorate
  end

  def pending
    @quotes = Quote.with_pending_requests
    @quotes = filter_quotes_by_params(params).decorate
  end

  # GET /quotes/1
  # GET /quotes/1.json
  def show
    @quote = Quote.find(params[:id]).decorate
    respond_with(@quote)
  end

  # GET /quotes/new
  # GET /quotes/new.json
  def new
    @quote = Quote.new
    initialize_quote_associations_for_form
    set_quotes_today_counter

    respond_with(@quote)
  end

  # GET /quotes/1/edit
  def edit
    @quote = Quote.find(params[:id])
    initialize_quote_associations_for_form
    set_quotes_today_counter
  end

  # POST /quotes
  # POST /quotes.json
  def create
    @quote = Quote.new(params[:quote])

    if @quote.save
      @quote.compute_total_offered_prices
      Purchase.make(@quote.offers.purchased)
    else
      initialize_quote_associations_for_form
      set_quotes_today_counter
    end

    respond_with(@quote)
  end

  # PUT /quotes/1
  # PUT /quotes/1.json
  def update
    @quote = Quote.find(params[:id])

    if @quote.update_attributes(params[:quote])
      @quote.reindex
      @quote.compute_total_offered_prices
      Purchase.make(@quote.offers.purchased)
    else
      initialize_quote_associations_for_form
      set_quotes_today_counter
    end

    respond_with(@quote)
  end

  def printable_view

    @quote = Quote.find(params[:id])

    if params[:supplier_id].blank?
      @suppliers = 'all'
      @requests = @quote.requests
    else
      @suppliers = @quote.suppliers.where(id: params[:supplier_id]).uniq
      @supplier_names = @suppliers.map(&:name).join(',')
      @requests = @quote.requests.includes(:suppliers).where(suppliers: {id: @suppliers.map(&:id)})
    end

    @quote = @quote.decorate

    @print_preview = true

    render layout: "printable"
  end

  def requote
    @parent_quote = Quote.find(params[:id])
    @quote = @parent_quote.requote!

    if @quote.persisted?
      redirect_to @quote
    else
      redirect_to quotes_url
    end
  end

  # DELETE /quotes/1
  # DELETE /quotes/1.json
  def destroy
    @quote = Quote.find(params[:id])
    @quote.destroy

    respond_with(@quote)
  end

  def set_badge_count
    offers_required = Quote.with_pending_requests
    awaiting_order = Quote.pending_client_order

    if params[:client_id].present?
      offers_required = offers_required.where(client_id: params[:client_id])
      awaiting_order = awaiting_order.where(client_id: params[:client_id])
    end

    @offers_required_count = offers_required.count
    @awaiting_order_count = awaiting_order.count
  end

  private

  def set_quotes_today_counter
    @quotes_today = Quote.today
  end

  def filter_quotes_by_params(params)
    unless params[:client_id].blank?
      @quotes = @quotes.where(client_id: params[:client_id])
    end

    unless params[:supplier_id].blank?
      @quotes = @quotes.includes(:suppliers).where(suppliers: { id: params[:supplier_id] })
    end

    @quotes = @quotes.page(params[:page]).per_page(40)
  end

  def initialize_quote_associations_for_form
    if @quote.requests.empty?
      @quote.requests.build
      # @quote.requests.first.offers.build
    end
    @quote.attachments.build if @quote.attachments.empty?
  end

end
