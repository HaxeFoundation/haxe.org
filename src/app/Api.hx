package app;

import clientds.ClientDsApi;
import ufront.api.UFApiContext;

import app.api.*;

/** Seems to require explicit imports... */
class Api extends UFApiContext
{
	// App specific
	public var pageApi:PageApi;
	public var manualApi:ManualApi;

	// Vendor
	public var clientDsApi:ClientDsApi;
}