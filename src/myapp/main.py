from sys import exit

from myapp.mylib.lib import lib_hello


def main() -> int:
    print(lib_hello(0))
    print(lib_hello(1))
    return 0


if __name__ == "__main__":
    exit(main())  # pragma: no cover
