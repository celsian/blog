@app = angular.module('Blog', ["ngResource"])

@app.controller "PostCtrl", ['$scope', '$resource', ($scope, $resource) ->
  Posts = $resource("/posts/:id.json", {id: "@id"}, {update: {method: "PUT"}})
  $scope.posts = Posts.query()

  $scope.addPost = ->
    post = Posts.save($scope.newPost)
    $scope.posts.unshift(post)
    $scope.newPost = {}
    $scope.testing = post

  $scope.removeEntry = (post) ->
    index = $scope.posts.indexOf(post)
    $scope.posts.splice(index, 1)
    Posts.remove(post)
]