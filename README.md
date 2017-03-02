# webmaniabr-correios.hx

Search addresses for Brazilian ZIP codes – known locally as CEPs – with the
[WebmaniaBR REST API](https://webmaniabr.com/docs/rest-api-correios/).

## Usage

```haxe
var api = new Correios(appKey, appSecret);
api.queryCep("80540-180", function (res) {
	switch res {
	case Some(address):  // zip code exists
		trace(address);
	case None:           // zip code doesn't exist
		trace("unkown cep");
	case Failure(err):   // api failure
		trace('api error: $err');
	}
});
```

```
{ endereco: "Avenida Anita Garibaldi", bairro: "Ahú", cidade: "Curitiba", uf: "PR", cep: "80540-180" }
```

