# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

console.log "Shit"

services = angular.module('app', ['ngResource'])

services.factory "Offer", [ '$resource', ($resource) ->
  return $resource "/clients/#{window.client_id}/offers.json?page=#{window.page}"
]

services.controller "OffersController", (Offer, $scope) ->

  $scope.client_id = window.client_id
  $scope.showForm = ($event) ->
    replace =  $event.target
    # window.x = replace
    # console.log replace

    window.list = Offer.query()
    console.log window.list

