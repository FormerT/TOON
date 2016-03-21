# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# TODO feeds/index でタグ追加機能が実装されたら削除
#items = ["line","aws"]
#localStorage.setItem("tags", JSON.stringify(items))

$ ->
  vm = new Vue(
    el: '#tags'
    created: ->
      # 削除ボタン非表示
      $('.delete-btn').hide()
    data: {
      tags: JSON.parse(localStorage.getItem('tags')),
      # スワイプ判定用 position
      swipeX: -1,
      swipeY: -1
    }
    methods: {
      # 検索枠入力後、自動でsubmit
      keyword: (event) ->
        $(event.target).parents('form').submit()

      # 削除ボタン非表示
      delete: (event) ->
        $(event.target).parent().slideUp('fast')
        deleteStorage($(event.target).prev('a').text())
        #$(event.target).prev('a').preventDefault()

      # スワイプ開始時: 座標を記録
      swipe_start: (event) ->
        vm.swipeX = event.changedTouches[0].pageX
        vm.swipeY = event.changedTouches[0].pageY

      # スワイプ終了時: 座標リセット
      swipe_end: (event) ->
        vm.swipeX = -1

      # スワイプ時: 左に35px以上スワイプされた場合に削除ボタンを表示
      swipe_move: (event) ->
        if Math.abs(event.changedTouches[0].pageY - vm.swipeY) > 10
          vm.swipeX = -1
        if vm.swipeX != -1 && Math.abs(event.changedTouches[0].pageX - vm.swipeX) > 35
          vm.swipeX = -1

          # event.target が SECTIONの場合、A の場合があるため、それぞれに対応した削除ボタン, a タグのオブジェクトを取得
          $deleteObj = if event.target.tagName == 'SECTION' then $(event.target).children('div.delete-btn') else $(event.target).next('div.delete-btn')
          $linkObj = if event.target.tagName == 'SECTION' then $(event.target).children('a') else $(event.target)

          if $deleteObj.is(':visible')
            $('.delete-btn').hide()
            # onclick return false の解除
            $('.swipe-tag a').attr('onclick', '')
          else
            $('.delete-btn').hide()
            # onclick return false の解除
            $('.swipe-tag a').attr('onclick', '')

            $deleteObj.show()
            # onclick で a タグを無効化
            $linkObj.attr('onclick', 'return false')
    }
  )

# localStorageから該当のタグを削除
deleteStorage = (key) ->
  tags = JSON.parse(localStorage.getItem('tags'))
  tags.some (val, index) ->
    if (val == key)
      tags.splice(index, 1)
  localStorage.setItem('tags', JSON.stringify(tags))
