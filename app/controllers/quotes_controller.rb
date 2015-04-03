class QuotesController < ApplicationController

  before_filter :set_badge_count, only: [:index, :pending_client_po, :pending]

  # GET /quotes
  # GET /quotes.json
  def index
    @quotes = Quote.page(params[:page]).per_page(20)

    unless params[:client_id].blank?
      @quotes = @quotes.where(client_id: params[:client_id])
    end

    @quotes = @quotes.decorate

    respond_with(@quotes)
  end

  # TODO : Change name? the path name is ugly (pending_client_po_quote_path)
  # must be a sign that there is a better name for this out there.
  def pending_client_po
    @quotes = Quote.pending_client_order.page(params[:page]).per_page(20).decorate
    unless params[:client_id].blank?
      @quotes = @quotes.where(client_id: params[:client_id])
    end
  end

  def pending
    @quotes = Quote.with_pending_requests
    unless params[:client_id].blank?
      @quotes = @quotes.where(client_id: params[:client_id])
    end
    @quotes = @quotes.page(params[:page]).per_page(20).decorate
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
    @quote.requests.build
    @quote.attachments.build
    @quotes_today = Quote.today

    respond_with(@quote)
  end

  # GET /quotes/1/edit
  def edit
    @quote = Quote.find(params[:id])
    @quote.requests.build if @quote.requests.empty?
    @quote.attachments.build if @quote.attachments.empty?
    @quotes_today = Quote.today
  end

  # POST /quotes
  # POST /quotes.json
  def create
    @quote = Quote.new(params[:quote])

    respond_to do |format|
      if @quote.save
        @quote.compute_total_offered_prices

        # FIME : write this quote instance method `@quote.order_purchased_from_supplier?`
        # that contains the line below
        Purchase.make(@quote.offers.purchased)

        format.html { redirect_to @quote, notice: 'Quote was successfully created.' }
        format.json { render json: @quote, status: :created, location: @quote }
      else
        format.html { render action: "new" }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /quotes/1
  # PUT /quotes/1.json
  def update
    @quote = Quote.find(params[:id])

    respond_to do |format|
      if @quote.update_attributes(params[:quote])
        @quote.reindex
        @quote.compute_total_offered_prices
        Purchase.make(@quote.offers.purchased)
        format.html { redirect_to @quote, notice: 'Quote was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
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

    # respond_to do |format|
    #   if @quote.persisted?
    #     format.html { redirect_to @quote, notice: 'Quote was successfully requoted.' }
    #     format.json { head :no_content }
    #   else
    #     format.html { redirect_to quotes_url }
    #     format.json { render json: @quote.errors, status: :unprocessable_entity }
    #   end
    # end

    respond_with(@quote)
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

end
