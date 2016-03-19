# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# TODO スタブデータ feedsができたら削除
items = ["line","aws"]
localStorage.setItem("tags", JSON.stringify(items))

$ ->
  demo = new Vue(
    el: '#tags'
    data: {
      tags: JSON.parse(localStorage.getItem('tags'))
    }
  )

  $('#keyword').change ->
    $('#text_search_form').submit()
