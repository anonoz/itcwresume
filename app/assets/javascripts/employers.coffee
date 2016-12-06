#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require angular
angular.module('employers', []).
  controller('resumes_index_controller', ['$scope', ($scope)->
    $scope.init = ->
      $scope.resumes = JSON.parse document.getElementById('resumes_json').innerHTML
  ])
