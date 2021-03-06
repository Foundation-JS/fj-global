$ = require 'fj-config'
{lowerBound, upperBound, stripUnit, convertToRem, data, remCalc, rgba} = require 'fj-functions'

$.namespace = false

$.experimental = true

$.baseFontSize = '100%'

$.baseLineHeight = '150%'


$.bodyBg = '#fff'
$.bodyFontColor = '#222'
$.bodyFontFamily = '"Helvetica Neue", "Helvetica", Helvetica, Arial, sans-serif'
$.bodyFontWeight = 'normal'
$.bodyFontStyle = 'normal'

$.fontSmoothing = 'antialiased'

$.textDirection = 'ltr'
$.defaultFloat = 'left'
$.oppositeDirection = 'right'

$.primaryColor = '#008CBA'
$.secondaryColor = '#e7e7e7'
$.alertColor = '#f04124'
$.successColor = '#43AC6A'
$.warningColor = '#f08a24'
$.infoColor = '#a0d3e8'

$.globalRadius = '3px'
$.globalRounded = '1000px'

$.shinyEdgeSize = '0 1px 0'
$.shinyEdgeColor = rgba('#fff', 0.5)
$.shinyEdgeActiveColor = rgba('#000', 0.2)

$.includeHtmlClasses = true
$.includePrintStyles = true
$.includeHtmlGlobalClasses = $.includeHtmlClasses

$.smallRange = ['0em', '40em']
$.mediumRange = ['40.063em', '64em']
$.largeRange = ['64.063em', '90em']
$.xlargeRange = ['90.063em', '120em']
$.xxlargeRange = ['120.063em', '99999999em']

$.screen = "only screen"

$.landscape = "#{$.screen} and (orientation: landscape)"
$.portrait = "#{$.screen} and (orientation: portrait)"

$.smallUp = $.screen
$.smallOnly = "#{$.screen} and (max-width: #{upperBound($.smallRange)})"

$.mediumUp = "#{$.screen} and (min-width:#{lowerBound($.mediumRange)})"
$.mediumOnly = "#{$.screen} and (min-width:#{lowerBound($.mediumRange)}) and (max-width:#{upperBound($.mediumRange)})"

$.largeUp = "#{$.screen} and (min-width:#{lowerBound($.largeRange)})"
$.largeOnly = "#{$.screen} and (min-width:#{lowerBound($.largeRange)}) and (max-width:#{upperBound($.largeRange)})"

$.xlargeUp = "#{$.screen} and (min-width:#{lowerBound($.xlargeRange)})"
$.xlargeOnly = "#{$.screen} and (min-width:#{lowerBound($.xlargeRange)}) and (max-width:#{upperBound($.xlargeRange)})"

$.xxlargeUp = "#{$.screen} and (min-width:#{lowerBound($.xxlargeRange)})"
$.xxlargeOnly = "#{$.screen} and (min-width:#{lowerBound($.xxlargeRange)}) and (max-width:#{upperBound($.xxlargeRange)})"

$.small = $.mediumUp
$.medium = $.mediumUp
$.large = $.largeUp

$.cursorCrosshairValue = 'crosshair'
$.cursorDefaultValue = 'default'
$.cursorPointerValue = 'pointer'
$.cursorHelpValue = 'help'
$.cursorTextValue = 'text'


boxSizing = (type) ->
    type ?= 'border-box'
    s = bxz: type
    if $.experimental
        s['-wm-box-sizing'] = type
    s

clearfix = ->
    '*zoom': 1
    '&:before, &:after':
        ct: ' '
        d: 'tb'
    ':after':
        cl: 'b'

module.exports =
    toggleTextDirection: (direction) ->
        $.textDirection = direction if direction?
        if $.textDirection is 'ltr'
            $.defaultFloat = 'left'
            $.oppositeDirection = 'right'
        else
            $.defaultFloat = 'right'
            $.oppositeDirection = 'left'

    radius: (radius) ->
        radius ?= $.globalRadius
        if radius
            s = bdrsa: radius
            if $.experimental
                s['-webkit-border-radius'] = radius
        s

    sideRadius: (side, radius) ->
        radius ?= $.globalRadius
        s = {}
        s["border-bottom-#{side}-radius"] = radius    
        s["border-top-#{side}-radius"] = radius
        if $.experimental
            s["-moz-border-radius-bottom#{side}"] = radius
            s["-moz-border-radius-top#{side}"] = radius
            s["-webkit-border-bottom-#{side}-radius"] = radius
            s["-webkit-border-top-#{side}-radius"] = radius
        s

    insetShadow: (active) ->
        active ?= true
        s = bxsh: $.shinyEdgeSize + ' ' + (if active then $.shinyEdgeActiveColor else $.shinyEdgeColor) + ' inset'
        if $.experimental
            s['-webkit-box-shadow'] = s.bxsh
        if active
            s = ':active': s
        s

    singleTransition: (property, speed, ease) ->
        property ?= 'all'
        speed ?= 300
        ease ?= 'ease-out'
        s = trs: property + ' ' + speed + 'ms ' + ease
        if $.experimental
            s['-moz-transition'] = s['-webkit-transition'] = s.trs
        s

    boxSizing: boxSizing

    cssTriangle: (size, color, direction) ->
        s =
            ct: ''
            d: 'b'
            wid: 0
            hei: 0
            bd: 'inset ' + size
        cl = [0..3].map -> 'tra'
        if direction is 'top'
            cl[0] = color
            s.bdts = 's'
        if direction is 'bottom'
            cl[2] = color
            s.bdbs = 's'
        if direction is 'left'
            cl[3] = color
            s.bdls = 's'
        if direction is 'right'
            cl[1] = color
            s.bdrs = 's'
        s.bdc = cl.join ' '
        s

    clearfix: clearfix

    blockGlowingEffect: (selector, fadeTime, glowingEffectColor) ->
        selector ?= 'focus'
        fadeTime ?= 300
        glowingEffectColor ?= "fade-out(#{$.primaryColor}, .25)"
        selector = ':' + selector
        s = trs: "box-shadow #{fadeTime}ms, border-color #{fadeTime}ms ease-in-out"
        s[selector] =
            bxsh: "0 0 5px #{glowingEffectColor}"
            bdc: glowingEffectColor
        if $.experimental
            s['-webkit-transition'] = "-webkit-box-shadow #{fadeTime}ms, border-color #{fadeTime}ms ease-in-out"
            s['-moz-transition'] = "-moz-box-shadow #{fadeTime}ms, border-color #{fadeTime}ms ease-in-out"
            s[selector] =
                '-wm-box-shadow': "0 0 5px #{glowingEffectColor}"
        s

    translate2d: (horizontal, vertical) ->
        horizontal ?= 0
        vertical ?= 0
        s = trf: "translate(#{horizontal},#{vertical})"
        if $.experimental
            s['-wmso-transform'] = s.trf
        s

    style: [base, html]

base =
    meta:
        '&.foundation-version':
            ff: '/5.1.0/'
        '&.foundation-mq-small':
            ff: '/' + $.smallOnly + '/'
            wid: lowerBound $.smallRange
        '&.foundation-mq-medium':
            ff: '/' + $.mediumUp + '/'
            wid: lowerBound $.mediumRange
        '&.foundation-mq-large':
            ff: '/' + $.largeUp + '/'
            wid: lowerBound $.largeRange
        '&.foundation-mq-xlarge':
            ff: '/' + $.xlargeUp + '/'
            wid: lowerBound $.xlargeRange
        '&.foundation-mq-xxlarge':
            ff: '/'+ $.xxlargeUp + '/'
            wid: lowerBound $.xxlargeRange
        '&.foundation-data-attribute-namespace':
            ff: $.namespace
    'html, body':
        hei: '100%'


html = ->
    return {} unless $.includeHtmlGlobalClasses
    '*, *:before, *:after': boxSizing()
    'html, body':
        fz: $.baseFontSize
    body:
        bg: $.bodyBg
        col: $.bodyFontColor
        pad: 0
        mar: 0
        ff: $.bodyFontFamily
        fw: $.bodyFontWeight
        fs: $.bodyFontStyle
        pos: 'relative'
        cur: $.cursorDefaultValue
    'a:hover':
        cur: $.cursorPointerValue
    'img, object, embed':
        maw: '100%'
        h: 'a'
    'object, embed':
        hei: '100%'
    img:
        '-ms-interpolation-mode': 'bicubic'
    '#map_canvas, .map_canvas':
        'img, embed, object':
            maw: 'none !important'

    '.left':
        'float': 'left !important'
    '.right':
        'float': 'right !important'
    '.clearfix': clearfix()
    '.hide':
        d: 'n'
    '.antialiased':
        '-webkit-font-smoothing': 'antialiased'
        '-moz-osx-font-smoothing': 'grayscale'
    img:
        d: 'i'
        va: 'm'
    textarea:
        h: 'a'
        mih: '50px'
    select:
        wid: '100%'