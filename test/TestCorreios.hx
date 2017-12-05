import utest.Assert;

import webmaniabr.Correios;

class TestCorreios {
	static var asyncTimeout = 10000;  // ms

	var api = new Correios("PxQtu0NJd0v6B2sPBUR0leTE8Eryi1ZN", "KffqAXnZIz6Wmb9pYWYkCFag0qHw1z4jsKHeKw3IpKF39Qur");

	public function test_000_usage_example()
	{
		var done = Assert.createAsync(asyncTimeout);
		api.queryCep("80540-180", function (res) {
			switch res {
			case Some(address):
				Assert.same({
					endereco : "Avenida Anita Garibaldi",
					bairro : "Ahú",
					cidade : "Curitiba",
					uf : "PR",
					cep : "80540180"
				}, address);
			case None:
				Assert.fail(Std.string(res));
			case Failure(err):
				Assert.fail(err);
			}
			done();
		});
	}

	public function test_001_existing_cep()
	{
		var done = Assert.createAsync(asyncTimeout);
		api.queryCep("80540-180", function (res) {
			Assert.same(Some({
					endereco : "Avenida Anita Garibaldi",
					bairro : "Ahú",
					cidade : "Curitiba",
					uf : "PR",
					cep : "80540180"
				}), res);
			done();
		});
	}

	public function test_002_unknown_cep()
	{
		var done = Assert.createAsync(asyncTimeout);
		api.queryCep("20040-600", function (res) {
			Assert.same(None, res);
			done();
		});
	}
	public function new() {}
}

