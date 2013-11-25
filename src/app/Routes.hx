package app;

import ufront.web.Dispatch;
import ufront.web.Controller;
import app.controller.*;
// import ufront.ufadmin.controller.UFAdminController;

class Routes extends Controller
{
	public function doDefault( d:Dispatch ) return d.returnDispatch( new PageController() );
	public function doManual( d:Dispatch ) return d.returnDispatch( new ManualController() );
	public function doDownload( d:Dispatch ) return d.returnDispatch( new DownloadController() );
	public function doUpdate( d:Dispatch ) return d.returnDispatch( new UpdateController() );
	public function doSearch( d:Dispatch ) return d.returnDispatch( new SearchController() );
	// public function doUFAdmin( d:Dispatch ) return d.returnDispatch( new UFAdminController() );
}