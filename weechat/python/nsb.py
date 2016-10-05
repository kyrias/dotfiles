# -*- coding: utf-8 -*-
import weechat

operation = {}
hooks     = {}

weechat.register('nsb', 'Johannes Löthberg', '0.0.1', 'ISC', 'Ban users by NickServ nick', 'unload', 'UTF-8')
hooks['command']  = weechat.hook_command("nsb", "ban nick by ns account name",
                                         "ban <nick> || unban <nick>",
                                         "  ban: Ban a user\nunban: Unban a user\n",
                                         "ban %(nick) || unban %(nick)",
                                         "ns_ban_cb", "")

infolist_buffer = ""

def infolist_display(buffer, args):
	items = args.split(" ", 1)
	infolist_args = ""
	infolist_pointer = ""
	if len(items) >= 2:
		infolist_args = items[1]
		if infolist_args[:2] == "0x":
			infolist_pointer, sep, infolist_args = infolist_args.partition(" ")
		elif infolist_args[:3] == "\"\" ":
			infolist_args = infolist_args[3:]

	infolist = weechat.infolist_get(items[0], infolist_pointer, infolist_args)
	if infolist == "":
		weechat.prnt_date_tags(buffer, 0, "no_filter",
				"%sInfolist '%s' not found."
				% (weechat.prefix("error"), items[0]))
		return weechat.WEECHAT_RC_OK

	item_count = 0
	weechat.buffer_clear(buffer)
	weechat.prnt(buffer, "")
	count = 0
	while weechat.infolist_next(infolist):
		item_count += 1
		if item_count > 1:
			weechat.prnt(buffer, "")

		fields = weechat.infolist_fields(infolist).split(",")
		for field in fields:
			(type, name) = field.split(":", 1)
			if name != 'host':
				continue
			value = weechat.infolist_string(infolist, name)
			name_end = "." * (30 - len(name))
			weechat.prnt(buffer, "%s: %s%s" %
					(name, weechat.color("cyan"), value))
			prefix = ""
			count += 1
	if count == 0:
		weechat.prnt_date_tags(buffer, 0, "no_filter", "Empty infolist.")
	weechat.infolist_free(infolist)
	return weechat.WEECHAT_RC_OK

def ns_ban_cb(data, buffer, args):
	args = args.split()
	oper = args[0]
	nick = args[1]

	channel = weechat.buffer_get_string(buffer, 'localvar_channel')
	server = weechat.buffer_get_string(buffer, 'localvar_server')

	if oper == 'ban':
		found = False
		infolist = weechat.infolist_get("irc_nick", "", "{},{},{}".format(server, channel, nick))
		while weechat.infolist_next(infolist):
			found = True
			account = weechat.infolist_string(infolist, "account")
			if account:
				weechat.command("", '/mode +b $a:{}'.format(account))

		weechat.infolist_free(infolist)

		if not found:
			# TODO: Handle numeric 315 too, ‘End of /WHO list’
			hooks['who'] = weechat.hook_modifier("irc_in_354", "who_mod_cb", "")
			weechat.command("", "/who %s n%%an" % args[1])
			operation[nick] = oper

	else:
		# TODO: Handle numeric 315 too, ‘End of /WHO list’
		hooks['who'] = weechat.hook_modifier("irc_in_354", "who_mod_cb", "")
		weechat.command("", "/who %s n%%an" % args[1])

		operation[nick] = oper

	return weechat.WEECHAT_RC_OK

def who_mod_cb(data, modifier, modifier_data, string):
	ns_name = string.split()[-1]
	nick    = string.split()[-2]
	mode    = operation.pop(nick)

	weechat.unhook(hooks.pop('who'))

	if mode == 'ban':
		weechat.command("", '/mode +b $a:{}'.format(ns_name))
	elif mode == 'unban':
		weechat.command("", '/mode -b $a:{}'.format(ns_name))
	elif not mode:
		weechat.prnt('', 'nsb: "mode" variable not set in who_cb')
	else:
		weechat.prnt('', 'nsb: err, something bork')

	return ""

def unload():
	weechat.unhook(hooks['command'])
	return weechat.WEECHAT_RC_OK
