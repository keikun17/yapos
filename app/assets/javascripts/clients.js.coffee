# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

offers = angular.module('app', ['ngResource'])

offers.factory "Offer", [ '$resource', ($resource) ->
  return $resource "/clients/#{window.client_id}/offers.json?page=#{window.page}"
]

offers.controller "OffersController", (Offer, $scope) ->

  $scope.client_id = window.client_id

  $scope.toggleEditable = ($event) ->
    # editable_value =  $($event.target)
    # editable_value.hide()
    # form = $(editable_value.siblings('.edit-form'))
    # form.removeClass('hidden')
    # window.x = editable_value

  $scope.offers = Offer.query ->

  $scope.saveOrder = ->
    console.log "Saved"

  $scope.quote_url = (quote_id) ->
    "/quotes/#{quote_id}"

  $scope.order_url = (order_id) ->
    "/orders/#{order_id}"

  $scope.show_or_edit_order_purchase_date = (offer) ->
    if offer.order_id and !offer.order_purchase_date
     "[?]"
    else
      return offer.order_purchase_date


