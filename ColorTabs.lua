local p = {}

local getArgs = require('Module:Arguments').getArgs
local yesno = require('Module:Yesno')

function p.main(frame)
	local args = getArgs(frame)
	return p._main(args)
end

function p._main(args)
	local id = args['id']
	if not id or not tonumber(id) then
		id = '0'
	end
	local color = args['color'] or 'Lila'
	local tabs = mw.html.create()
		:tag('div')
			:attr('id', id)
			:attr('class', 'mc' .. color)
	local top = tabs:tag('div')
	local i = 1
	local sel = args['sel']
	local bticon, link, bt, tab
	while true do
		if args['bt' .. i] then
			bticon = args['bticon' .. i]
			link = args['link' .. i] or ((args['PageName'] or mw.title.getCurrentTitle().fullText) .. '/' .. (args['urlPrev'] or '') .. args['bt' .. i] .. (args['urlPost'] or ''))
			bt = args['bt' .. i]
			top:wikitext(makeTab(i, id, sel, bticon, link, bt))
			i = i + 1
		else
			istrue = false
			break
		end
	end
	top:done()
	local content = tabs:tag('div'):attr('class', 'mcContingut')
	local s = 1
	while s < i do
		tab = args['tab' .. i]
		content:wikitext(makeContent(id, sel, tab))
		s = s + 1
	end
	return tostring(frame:extensionTag{ name = 'templatestyles', args = { src = 'Template:Tabs/styles.css'} }) .. tostring(tabs)
end

function makeTab(i, id, sel, bticon, link, bt)
	return tostring(
		mw.html.create()
			:tag('div')
				:attr('id', 'mc' .. id .. 'bt' .. i)
				:attr('class', 'mcBoto' .. (tonumber(sel) == i and 'Sel' or ''))
				:wikitext((bticon and bticon .. '&nbsp;' or '') .. '[[' .. link .. '|' .. bt .. ']]')
				:done()
	)
end

function makeContent(id, sel, tab)
	return tostring(
		mw.html.create()
			:tag('div')
				:attr('id', 'mc' .. id .. 'ps' .. i)
				:attr('class', 'mcPestanya')
				:attr('style', (tonumber(sel) == i and 'display:block;visibility:visible;' or 'display:none;visibility:hidden;'))
				:wikitext(tab or '沒有內容。')
				:done()
	)
end

return p
