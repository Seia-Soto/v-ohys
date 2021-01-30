module ohys_api

import net.http
import json

pub struct FeedItem {
	name string [json: t]
	link string [json: a]
}

pub fn get_feed(page int) ?([]FeedItem) {
	body := http.get('https://eu.ohys.net/t/json.php?dir=disk&p=$page') or {
		return error(err)
	}
	data := json.decode([]FeedItem, body.text) or {
		return error('Failed to decode body: $body')
	}

	return data
}
