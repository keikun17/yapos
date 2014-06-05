class QuotesController < ApplicationController
  # GET /quotes
  # GET /quotes.json
  def index
    @quotes = Quote.paginate(:page => params[:page], :per_page => 20)
    @decorated_quotes = QuoteDecorator.decorate_collection(@quotes)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @quotes }
    end
  end

  # TODO : Change name? the path name is ugly (pending_client_po_quote_path)
  # must be a sign that there is a better name for this out there.
  def pending_client_po
    @quotes = Quote.pending_client_order.paginate(page: params[:page], per_page:20)
    @decorated_quotes = QuoteDecorator.decorate_collection(@quotes)
  end

  def pending
    @quotes = Quote.with_pending_requests
    @quotes = @quotes.paginate(page: params[:page], per_page: 20)
    @decorated_quotes = QuoteDecorator.decorate_collection(@quotes)
  end

  # GET /quotes/1
  # GET /quotes/1.json
  def show
    @quote = Quote.find(params[:id])
    @quote = QuoteDecorator.new(@quote)
    @requests = RequestDecorator.decorate_collection @quote.requests

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @quote }
    end
  end

  # GET /quotes/new
  # GET /quotes/new.json
  def new
    @quote = Quote.new
    @quote.requests.build
    @quote.attachments.build
    @quotes_today = Quote.today
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @quote }
    end
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
    @quote = QuoteDecorator.new(@quote)

    if params[:supplier_id].nil?
      @suppliers = 'all'
      @requests = @quote.requests
    else
      @suppliers = @quote.suppliers.where(id: params[:supplier_id]).uniq
      @supplier_names = @suppliers.map(&:name).join(',')
      @requests = @quote.requests.includes(:suppliers).where(suppliers: {id: @suppliers.map(&:id)})
    end

    @requests = RequestDecorator.decorate_collection(@requests)
    @print_preview = true

    render layout: "printable"
  end

  def requote
    @parent_quote = Quote.find(params[:id])
    @quote = @parent_quote.requote!
    respond_to do |format|
      if @quote.persisted?
        format.html { redirect_to @quote, notice: 'Quote was successfully requoted.' }
        format.json { head :no_content }
      else
        format.html { redirect_to quotes_url }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1
  # DELETE /quotes/1.json
  def destroy
    @quote = Quote.find(params[:id])
    @quote.destroy

    respond_to do |format|
      format.html { redirect_to quotes_url }
      format.json { head :no_content }
    end
  end

end
