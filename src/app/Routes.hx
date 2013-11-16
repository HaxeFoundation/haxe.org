package app;

import ufront.web.Dispatch;
import ufront.web.Controller;
import app.controller.*;
// import ufront.ufadmin.controller.UFAdminController;

class Routes extends Controller
{
	public function doDefault( d:Dispatch ) return d.returnDispatch( new PageController() );
	public function doUpdate( d:Dispatch ) return d.returnDispatch( new UpdateController() );
	// public function doUFAdmin( d:Dispatch ) return d.returnDispatch( new UFAdminController() );
}