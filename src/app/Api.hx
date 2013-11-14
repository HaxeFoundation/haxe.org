package app;

import clientds.ClientDsApi;
import ufront.api.UFApiContext;

import app.api.PageApi;

/** Seems to require explicit imports... */
class Api extends UFApiContext
{
	// App specific
	public var pageApi:PageApi;

	// Vendor
	public var clientDsApi:ClientDsApi;
}