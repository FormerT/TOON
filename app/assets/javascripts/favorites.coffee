# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# TODO スタブデータ feedsができたら削除
items = ["line","aws"]
localStorage.setItem("tags", JSON.stringify(items))

swipeX = -1
swipeY = -1

$ ->
  demo = new Vue(
    el: '#tags'
    data: {
      tags: JSON.parse(localStorage.getItem('tags'))
    }
  )

  # 検索枠入力後、自動でsubmit
  $('#keyword').change ->
    $('#text_search_form').submit()

  # 削除ボタン非表示
  $(".delete-btn").hide()

  # 削除クリック時
  $(".delete-btn").bind "touchstart", ->
    $(this).parent().slideUp("fast")
    $(this).prev('a').preventDefault()

  $(".tag-row").bind "touchstart", ->
    swipeX = event.changedTouches[0].pageX
    swipeY = event.changedTouches[0].pageY

  $(".tag-row").bind "touchend", ->
       swipeX = -1
       flag = 0

  $(".tag-row").bind "touchmove",->
       if Math.abs(event.changedTouches[0].pageY - swipeY) > 10
        swipeX = -1
       if swipeX != -1 && Math.abs(event.changedTouches[0].pageX - swipeX) > 35
           swipeX = -1
           # スワイプられた時の処理
           if $(this).children("div.delete-btn").is(':visible')
               $(".delete-btn").hide()
           else
               $(".delete-btn").hide()
               $(this).children("div.delete-btn").show()
