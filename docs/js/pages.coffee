$ ->
  $('.lang-coffeescript').each ->
    pre = $(this).parent()
    coffee = pre.text()
    js = CoffeeScript.compile(coffee, bare: true)
    .replace(/return\s(\w+\()/g, '$1')

    code = hljs.highlight('javascript', js).value.replace(/\n$/gm, '')

    pre.addClass 'lang-coffeescript'
    pre.wrap '<div class="code"></div>'
    div = pre.parent()
    div.height pre.height()
    div.prepend "<span class='toggle'>
      <span class='coffee'>view as js</span>
      <span class='js'>view as coffee</span>
    </span>"
    div.append "<pre class='lang-javascript'><code class='lang-javascript'>#{code}</code></pre>"

    toggle = div.find('.toggle')
    toggle.click ->
      div.toggleClass('compiled')
      if div.hasClass 'compiled'
        div.height div.find('.lang-javascript').data 'height'
      else
        div.height div.find('.lang-coffeescript').data 'height'

  pres = $('pre code')
  pres.each (i,el) ->

    el = $(el)
    parent = el.parent()
    parent.attr 'data-height', parent.height()
    text = el.html()
    lines = text.split('\n')
    parent.prepend "<ol>#{lines.map((l,i) -> "<li>#{i+1}</li>").join('')}</ol>"