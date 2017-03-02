package webmaniabr;

import haxe.Http;

typedef Cep = String;

typedef Address = {
	endereco : String,
	bairro : String,
	cidade : String,
	uf : String,
	cep : String
}

/*
Generic API response.

Can be:
 - the desired value (`Some(value)`),
 - the nonexistence of a response (`None`),
 - or an api failure wraper (`Failure(details)`)
*/
enum Response<S> {
	Some(response:S);
	None;
	Failure(error:Dynamic);
}

/*
Tools for the Brazilian Post Office – Correios
*/
class Correios {
	var appKey:String;
	var appSecret:String;

	/*
	Create a new API object.

	Register at
		https://webmaniabr.com/docs/rest-api-correios/
	for valid app key and secret.
	*/
	public function new(appKey, appSecret)
	{
		this.appKey = appKey;
		this.appSecret = appSecret;
	}

	/*
	Query the corresponding address for a Brazilian zip code (CEP).
	*/
	public function queryCep(cep:Cep, cb:Response<Address>->Void):Void
	{
		var req = new Http('https://webmaniabr.com/api/1/cep/$cep/?app_key=$appKey&app_secret=$appSecret');
		req.onStatus =
			function (status)
			{
				if (status != 200) {
#if (js || flash)
					req.cancel();
#end
					cb(Failure('Failed, status code was ${status}'));
				}
			}
		req.onData =
			function (data)
			{
				try {
					var a:Address = haxe.Json.parse(data);
					cb(a.uf == "" ? None : Some(a));
				} catch (err:Dynamic) {
					cb(Failure(err));
				}
			}
		req.onError = function (err) cb(Failure(err));
		req.addHeader("User-Agent", "Haxe; protocubo/webmaniabr-correios.hx; https://github.com/protocubo/webmaniabr-correios.hx");
		req.addHeader("Connection", "keep-alive");
		req.request();
	}
}

