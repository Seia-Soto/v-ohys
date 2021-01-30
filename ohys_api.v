module ohys_api

import net.http
import json
import regex

pub struct FeedItem {
	name string [json: t]
	link string [json: a]
}
pub struct Anime {
	original string [required]
	provider string
	series string
	episode int = -1
	channel string
	resolution string
	audio_format string
	video_format string
}

pub fn get_feed(mut page int) ?([]FeedItem) {
	if isnil(page) {
		page = 0
	}

	body := http.get('https://eu.ohys.net/t/json.php?dir=disk&p=$page') or {
		return error(err)
	}
	data := json.decode([]FeedItem, body.text) or {
		return error('Failed to decode body: $body.text')
	}

	return data
}
pub fn parse_title(title string) ?(Anime) {
	pattern := regex.new_regex('/(?:\[([^\r\n]*)\][\W]?)?(?:(?:([^\r\n]+?)(?: - ([0-9\-.]+?(?: END)?|SP))?)[\W]?[(|[]([^\r\n(]+)? (\d+x\d+|\d{3,}[^\r\n ]*)? ([^\r\n]+)?[)\]][^.\r\n]*(?:\.([^\r\n.]*)(?:\.[\w]+)?)?)$/gi', 0) or {
		return error('Failed to compile expression!')
	}
	result := pattern.match_str(title, 0, 0) or {
		return error('The title did not match anything!')
	}

	defer {
		pattern.free()
	}

	mut matches := result.get_all()
	mut data := Anime{
		original: matches[0]
		provider: matches[1]
		series: matches[2]
		episode: matches[3].int()
		channel: matches[4]
		resolution: matches[5]
		audio_format: matches[6]
		video_format: matches[7]
	}

	return data
}
