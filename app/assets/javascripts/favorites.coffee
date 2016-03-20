# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# TODO feeds/index でタグ追加機能が実装されたら削除
items = ["line","aws"]
localStorage.setItem("tags", JSON.stringify(items))

# スワイプ判定用 position
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
  $('.delete-btn').hide()

  # 削除クリック時
  $('.delete-btn').bind 'touchstart', ->
    $(this).parent().slideUp('fast')
    #$(this).prev('a').preventDefault()
    deleteStorage($(this).prev('a').text())

  # スワイプスタート時の座標を記録
  $('.swipe-tag').bind 'touchstart', ->
    swipeX = event.changedTouches[0].pageX
    swipeY = event.changedTouches[0].pageY

  # スワイプ終了時
  $('.swipe-tag').bind 'touchend', ->
    swipeX = -1

  # 左にスワイプされた場合に削除ボタンを表示
  $('.swipe-tag').bind 'touchmove',->
    if Math.abs(event.changedTouches[0].pageY - swipeY) > 10
      swipeX = -1
    if swipeX != -1 && Math.abs(event.changedTouches[0].pageX - swipeX) > 35
      swipeX = -1

      if $(this).children('div.delete-btn').is(':visible')
        $('.delete-btn').hide()
        # onclick return false の解除
        $('.swipe-tag a').attr('onclick', '')
      else
        $('.delete-btn').hide()
        # onclick return false の解除
        $('.swipe-tag a').attr('onclick', '')

        $(this).children('div.delete-btn').show()
        # onclick で a タグを無効化
        $(this).children('a').attr('onclick', 'return false')

# localStorageから該当のタグを削除
deleteStorage = (key) ->
  tags = JSON.parse(localStorage.getItem('tags'))
  tags.some (val, index) ->
    if (val == key)
      tags.splice(index, 1)
  localStorage.setItem('tags', JSON.stringify(tags))
