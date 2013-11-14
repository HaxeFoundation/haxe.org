package app.model;

import ufront.web.HttpError;
import haxe.ds.Option;
using tink.CoreApi;
using StringTools;
using haxe.io.Path;

abstract Manual( Array<ManualPage> ) from Array<ManualPage> to Array<ManualPage> {

	public var length(get,never):Int;
	inline function get_length() return this.length;

	public inline function iterator():Iterator<ManualPage> return this.iterator();

	public function pageFromUrl( url:String ):Outcome<ManualPage,HttpError> {
		var parts = url.split( "/" );
		var firstPart = parts.shift();

		if ( parts[parts.length-1]=="" ) parts.pop();

		for ( page in this ) {
			if ( page.url==firstPart ){
				var subManual:Manual = page.sub;
				if ( parts.length==0 ) return Success( page );
				else return subManual.pageFromUrl( parts.join("/") );
			}
		}
		return Failure( HttpError.pageNotFound() );
	}

	public function pageFromID( id:String ):Outcome<ManualPage,HttpError> {
		for ( page in this ) {
			if ( page.id==id ) return Success( page );
			else {
				var subManual:Manual = page.sub;
				var result = subManual.pageFromID( id );
				if ( result.isSuccess() ) return result;
			}
		}
		return Failure( HttpError.pageNotFound() );
	}

	public function pageFromFilename( filename:String ):Outcome<ManualPage,HttpError> {
		for ( page in this ) {
			if ( page.filename==filename ) return Success( page );
			else {
				var subManual:Manual = page.sub;
				var result = subManual.pageFromFilename( filename );
				if ( result.isSuccess() ) return result;
			}
		}
		return Failure( HttpError.pageNotFound() );
	}

	public function urlFromFilename( filename:String ):Outcome<String,Noise> {
		for ( page in this ) {
			if ( page.filename==filename ) return Success( page.url );
			else {
				var subManual:Manual = page.sub;
				switch subManual.urlFromFilename( filename ) {
					case Success( url ): return Success( '${page.url}/$url' );
					case Failure( _ ):
				}
			}
		}
		return Failure( Noise );
	}

	public function pageAfter( thisPage:ManualPage ):Option<ManualPage> {
		var parts = thisPage.id.split(".").map( Std.parseInt );
		while ( parts.length>0 ) {
			// Increment the final part, check if it exists
			var num = parts.pop();
			parts.push( num++ );
			var result = pageFromID( parts.join(".") );
			
			// If it exists, return it, otherwise, drop the final digit and incrememnt the next number
			if ( result.isSuccess() ) 
				return result.toOption();
			else 
				parts.pop();
		}
		return None;
	}

	public function pageBefore( thisPage:ManualPage ):Option<ManualPage> {
		var parts = thisPage.id.split(".").map( Std.parseInt );
		while ( parts.length>0 ) {
			var num = parts.pop();
			if ( num==1 ) {
				// We're at the top of this folder, try go to the next folder
				parts.pop();
			}
			else {
				// Same folder, one number lower
				parts.push( num-- );
				var result = pageFromID( parts.join(".") );
				return Some( result.sure() );
			}
		}
		return None;
	}
}

abstract ManualPage( ManualPageData ) from ManualPageData to ManualPageData {
	
	public var id(get,never):String;
	public var url(get,never):String;
	public var filename(get,never):String;
	public var title(get,never):String;
	public var sub(get,never):Manual;

	inline function get_label() {
		return (this.label!=null) ? this.label : this.title;
	}

	inline function get_id() return this.id;
	function get_url() {

		return get_label().toLowerCase().replace(" ", "-");
	}
	inline function get_filename() return '${this.id}-${get_label().replace(" ","_")}.md';
	inline function get_sub() return this.sub;
	inline function get_title() return this.title;
}

typedef ManualPageData = {
	label: String,
	id: String,
	sub: Array<ManualPageData>,
	title: String,
	index: String
}