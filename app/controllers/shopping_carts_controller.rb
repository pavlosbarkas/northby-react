#---
# Excerpted from "Modern Front-End Development for Rails, Second Edition",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/nrclient2 for more book information.
#---
class ShoppingCartsController < ApplicationController
  before_action :set_shopping_cart, only: %i[show edit update destroy]

  # GET /shopping_carts or /shopping_carts.json
  def index
    @shopping_carts = ShoppingCart.all
  end

  # GET /shopping_carts/1 or /shopping_carts/1.json
  def show
  end

  # GET /shopping_carts/new
  def new
    @shopping_cart = ShoppingCart.new
  end

  # GET /shopping_carts/1/edit
  def edit
  end

  # POST /shopping_carts or /shopping_carts.json
  def create
    seat_number = params[:seatNumber]
    seat_range = seat_number...seat_number + params[:ticketsToBuyCount]
    tickets = Ticket.where(
      concert_id: params[:concertId],
      row: params[:row],
      number: seat_range
    ).all

    tickets.update(
      status: params[:status],
      user: params[status] === "held" ? current_user.id : nil
    )

    render(json: tickets.map(&:to_concert_h))
  end

  # PATCH/PUT /shopping_carts/1 or /shopping_carts/1.json
  def update
    respond_to do |format|
      if @shopping_cart.update(shopping_cart_params)
        format.html { redirect_to @shopping_cart, notice: "Shopping cart was successfully updated." }
        format.json { render :show, status: :ok, location: @shopping_cart }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @shopping_cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shopping_carts/1 or /shopping_carts/1.json
  def destroy
    @shopping_cart.destroy
    respond_to do |format|
      format.html { redirect_to shopping_carts_url, notice: "Shopping cart was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_shopping_cart
    @shopping_cart = ShoppingCart.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def shopping_cart_params
    params.require(:shopping_cart).permit(:user_id)
  end
end
