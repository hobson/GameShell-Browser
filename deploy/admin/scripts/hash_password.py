"""Hash a password for ADMIN_PASSWORD_HASH — never store the plaintext.

Usage::
    python scripts/hash_password.py <password>

Paste the printed hash into deploy/admin/.env as ADMIN_PASSWORD_HASH=<hash>.
"""
import argparse

from flask_admin_toolkit import hash_password


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("password", help="Plaintext password to hash")
    args = parser.parse_args()
    print(hash_password(args.password))


if __name__ == "__main__":
    main()
