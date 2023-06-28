from myapp.main import main


class TestMain:
    def test_main(self) -> None:
        # Test main directly
        assert main() == 0
