class QuotesController < ApplicationController
  # GET /quotes
  # GET /quotes.json
  def index
    @quotes = Quote.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @quotes }
    end
  end

  def search
    valid_states = ['Pending', 'Cancelled', 'No Quote', 'Awarded']
    if valid_states.include?(params[:search][:state])
      @quotes = Quote.where(:status => params[:search][:state]).paginate(:page => params[:page], :per_page => 10)
    else
      flash[:error] = 'Invalid search terms'
      redirect_to :back
    end
    render :index
  end

  # GET /quotes/1
  # GET /quotes/1.json
  def show
    @quote = Quote.find(params[:id])

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
  end

  # POST /quotes
  # POST /quotes.json
  def create
    @quote = Quote.new(params[:quote])

    respond_to do |format|
      if @quote.save
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
        format.html { redirect_to @quote, notice: 'Quote was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
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
