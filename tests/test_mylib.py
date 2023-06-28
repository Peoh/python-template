from myapp.mylib.lib import lib_hello


def test_lib_hello() -> None:
    # Test library cases
    assert lib_hello(0) == "Hello"
    assert lib_hello(1) == "World"
