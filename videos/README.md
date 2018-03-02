# How to contribute videos

This is a guide to contribute videos to the haxe.org site.

You can add/modify json files in this directory to contribute content. 

### Structure

```json
{
	"title": "Title of the Collection",
	"description": "Description of the collection, may contain HTML",
	"videos": [
		{
			"featured": true,
			"where": "Location", 
			"title": "Title of the video",
			"description": "Description of the video, may contain HTML",
			"date": "2019-12-01",
			"youtubeId": "dQw4w9WgXcQ"
		},
		{
			"featured": false,
			"where": null,
			"title": "Other video",
			"description": "Description of the other video, may contain HTML",
			"date": "2019-12-02",
			"youtubeId": "dQw4w9WgXcQ"
		}
	]
}

```

### Rules

- JSON should be valid. Use [jsonlint](https://jsonlint.com/) to test before submitting.
- Max 5 videos can be featured per category.
- The videos must be mostly about Haxe or related tools / frameworks.
- The videos should not promote commercial services too much.
- The videos can be rejected by the team.
- The Haxe Foundation is not responsible for video content.