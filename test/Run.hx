class Run {
	static function main()
	{
		var runner = new utest.Runner();
		runner.addCase(new TestCorreios());
		
		utest.ui.Report.create(runner);
		runner.run();
	}
}

